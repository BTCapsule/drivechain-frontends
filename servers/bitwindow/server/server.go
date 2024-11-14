package server

import (
	"context"
	"database/sql"
	"errors"
	"fmt"
	"net"
	"net/http"
	"slices"
	"strings"
	"sync/atomic"
	"time"

	"connectrpc.com/connect"
	"connectrpc.com/grpcreflect"
	api_bitcoind "github.com/LayerTwo-Labs/sidesail/servers/bitwindow/api/bitcoind"
	api_drivechain "github.com/LayerTwo-Labs/sidesail/servers/bitwindow/api/drivechain"
	api_misc "github.com/LayerTwo-Labs/sidesail/servers/bitwindow/api/misc"
	api_wallet "github.com/LayerTwo-Labs/sidesail/servers/bitwindow/api/wallet"
	"github.com/LayerTwo-Labs/sidesail/servers/bitwindow/gen/bitcoind/v1/bitcoindv1connect"
	validatorrpc "github.com/LayerTwo-Labs/sidesail/servers/bitwindow/gen/cusf/mainchain/v1/mainchainv1connect"
	"github.com/LayerTwo-Labs/sidesail/servers/bitwindow/gen/drivechain/v1/drivechainv1connect"
	"github.com/LayerTwo-Labs/sidesail/servers/bitwindow/gen/misc/v1/miscv1connect"
	"github.com/LayerTwo-Labs/sidesail/servers/bitwindow/gen/wallet/v1/walletv1connect"
	"github.com/barebitcoin/btc-buf/server"
	"github.com/rs/zerolog"
	"github.com/samber/lo"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
)

// New creates a new Server with interceptors applied.
func New(
	ctx context.Context, bitcoind *server.Bitcoind,
	wallet validatorrpc.WalletServiceClient, enforcer validatorrpc.ValidatorServiceClient,
	database *sql.DB,
) (*Server, error) {
	mux := http.NewServeMux()
	srv := &Server{mux: mux}

	Register(srv, bitcoindv1connect.NewBitcoindServiceHandler, bitcoindv1connect.BitcoindServiceHandler(api_bitcoind.New(
		bitcoind,
	)))
	drivechainClient := drivechainv1connect.DrivechainServiceHandler(api_drivechain.New(
		bitcoind, enforcer,
	))
	Register(srv, drivechainv1connect.NewDrivechainServiceHandler, drivechainClient)
	Register(srv, walletv1connect.NewWalletServiceHandler, walletv1connect.WalletServiceHandler(api_wallet.New(
		ctx, bitcoind, wallet, drivechainClient,
	)))
	Register(srv, miscv1connect.NewMiscServiceHandler, miscv1connect.MiscServiceHandler(api_misc.New(
		database, bitcoind, wallet,
	)))

	return srv, nil
}

// Server exposes a set of Connect APIs over both gRPC and HTTP. Reflection is enabled.
type Server struct {
	// used for creating health and reflect services
	services []string

	mux    *http.ServeMux
	server *http.Server
}

func (s *Server) Handler() http.Handler {
	// Use h2c, so we can serve HTTP/2 without TLS.
	return h2c.NewHandler(s.mux, &http2.Server{})
}

func (s *Server) Serve(ctx context.Context, address string) error {
	log := zerolog.Ctx(ctx)

	services := lo.Map(s.services, func(svc string, index int) string {
		// Remove trailing and leading slashes
		return strings.Trim(svc, "/")
	})

	joinedServices := strings.Join(services, ", ")
	{
		log.Debug().
			Msgf("serve connect: enabling reflection: %s", joinedServices)

		reflector := grpcreflect.NewStaticReflector(s.services...)

		s.mux.Handle(grpcreflect.NewHandlerV1(reflector))
		s.mux.Handle(grpcreflect.NewHandlerV1Alpha(reflector))
	}

	lis, err := net.Listen("tcp", address)
	if err != nil {
		return fmt.Errorf("could not listen: %w", err)
	}

	defer func() {
		err := lis.Close()
		if err == nil {
			return
		}

		switch {
		case errors.Is(err, net.ErrClosed),
			errors.Is(err, http.ErrServerClosed):
			return
		}

		log.Error().Err(err).
			Msg("could not close listener")
	}()

	s.server = &http.Server{
		Handler: s.Handler(),
	}
	return s.server.Serve(lis)
}

// Shutdown tries to gracefully stop the server, forcing a shutdown
// after a timeout if this isn't possible. It is safe to call on a
// nil server.
func (s *Server) Shutdown(ctx context.Context) {
	if s == nil || s.server == nil {
		return
	}

	log := zerolog.Ctx(ctx)

	const timeout = time.Second * 3

	// If we have requests that don't complete, or streams that never close, we
	// risk hanging forever. Therefore, force stop after a timeout. Use int64
	// instead of bools, so we can load/add with the atomic package.
	var (
		stopped, forced int64
	)
	time.AfterFunc(timeout, func() {
		if atomic.LoadInt64(&stopped) != 0 {
			return
		}

		log.Printf("server: forcing stop after %s", timeout)
		atomic.AddInt64(&forced, 1)
		if err := s.server.Close(); err != nil {
			log.Err(err).Msg("server: could not force stop HTTP server")
			return
		}
	})

	log.Print("server: trying graceful stop")
	if err := s.server.Shutdown(context.Background()); err != nil {
		log.Err(err).Msg("server: could not gracefully stop HTTP server")
		return
	}

	if atomic.LoadInt64(&forced) == 0 {
		log.Info().Msg("server: successful graceful stop")
		log.Print("server: successful graceful stop")
	}

	log.Info().Msg("server: failed graceful stop")

	atomic.AddInt64(&stopped, 1)
}

// Register can be user to register a new sub-service to the server.
// This is _NOT_ a part of the Server API, because it is generic.
func Register[T any](
	s *Server,
	handler func(svc T, opts ...connect.HandlerOption) (string, http.Handler),
	svc T, opts ...connect.HandlerOption,
) {
	service, h := handler(svc,
		slices.Concat(
			opts,
		)...,
	)

	s.services = append(s.services, service)
	s.mux.Handle(service, h)
}
