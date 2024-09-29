package api_drivechain

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	pb "github.com/LayerTwo-Labs/sidesail/drivechain-server/gen/drivechain/v1"
	rpc "github.com/LayerTwo-Labs/sidesail/drivechain-server/gen/drivechain/v1/drivechainv1connect"
	"github.com/LayerTwo-Labs/sidesail/drivechain-server/gen/enforcer"
	coreproxy "github.com/barebitcoin/btc-buf/server"
	"github.com/btcsuite/btcd/chaincfg/chainhash"
	"github.com/rs/zerolog"
	"github.com/samber/lo"
)

var _ rpc.DrivechainServiceHandler = new(Server)

// New creates a new Server
func New(
	bitcoind *coreproxy.Bitcoind, enforcer enforcer.ValidatorClient,

) *Server {
	s := &Server{
		bitcoind: bitcoind, enforcer: enforcer,
	}
	return s
}

type Server struct {
	bitcoind *coreproxy.Bitcoind
	enforcer enforcer.ValidatorClient
}

// ListSidechainProposals implements drivechainv1connect.DrivechainServiceHandler.
func (s *Server) ListSidechainProposals(ctx context.Context, c *connect.Request[pb.ListSidechainProposalsRequest]) (*connect.Response[pb.ListSidechainProposalsResponse], error) {
	sidechainProposals, err := s.enforcer.GetSidechainProposals(ctx, &enforcer.GetSidechainProposalsRequest{})
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&pb.ListSidechainProposalsResponse{
		Proposals: lo.Map(sidechainProposals.SidechainProposals, func(proposal *enforcer.SidechainProposal, _ int) *pb.SidechainProposal {
			// TODO: I have no idea what the data hash looks like yet, needs to test this with real data
			dataHash, err := chainhash.NewHash(proposal.DataHash)
			if err != nil {
				dataHash, _ = chainhash.NewHashFromStr("deadbeef")
				zerolog.Ctx(ctx).Error().Err(err).Msg("could not create hash")
			}

			return &pb.SidechainProposal{
				Slot:           proposal.SidechainNumber,
				Data:           proposal.Data,
				DataHash:       dataHash.String(),
				VoteCount:      proposal.VoteCount,
				ProposalHeight: proposal.ProposalHeight,
				ProposalAge:    proposal.ProposalAge,
			}
		}),
	}), nil
}

// ListSidechains implements drivechainv1connect.DrivechainServiceHandler.
func (s *Server) ListSidechains(ctx context.Context, _ *connect.Request[pb.ListSidechainsRequest]) (*connect.Response[pb.ListSidechainsResponse], error) {
	sidechains, err := s.enforcer.GetSidechains(ctx, &enforcer.GetSidechainsRequest{})
	if err != nil {
		return nil, err
	}

	// Loop over all sidechains and get their chaintiptxid using s.enforcer.GetCtip()
	sidechainList := make([]*pb.ListSidechainsResponse_Sidechain, 0, len(sidechains.Sidechains))
	for _, sidechain := range sidechains.Sidechains {
		ctipResponse, err := s.enforcer.GetCtip(ctx, &enforcer.GetCtipRequest{SidechainNumber: sidechain.SidechainNumber})
		if err != nil {
			zerolog.Ctx(ctx).Error().Err(err).Uint32("sidechain", sidechain.SidechainNumber).Msg("failed to get ctip")
			continue
		}

		// Decode the txid using chainhash.NewHashFromStr
		txidHash, err := chainhash.NewHashFromStr(string(ctipResponse.Ctip.Txid))
		if err != nil {
			zerolog.Ctx(ctx).Error().Err(err).Msg("failed to decode txid")
			continue
		}

		decodedData := string(sidechain.Data)
		sidechainList = append(sidechainList, &pb.ListSidechainsResponse_Sidechain{
			Title:         decodedData, // TODO: Decode and fill in correctly
			Description:   decodedData, // TODO: Decode and fill in correctly
			Nversion:      uint32(ctipResponse.Ctip.SequenceNumber),
			Hashid1:       decodedData, // TODO: Decode and fill in correctly
			Hashid2:       decodedData, // TODO: Decode and fill in correctly
			Slot:          int32(sidechain.SidechainNumber),
			AmountSatoshi: int64(ctipResponse.Ctip.Value),
			ChaintipTxid:  fmt.Sprintf("%s:%d", txidHash.String(), ctipResponse.Ctip.Vout),
		})
	}

	return connect.NewResponse(&pb.ListSidechainsResponse{
		Sidechains: sidechainList,
	}), nil
}
