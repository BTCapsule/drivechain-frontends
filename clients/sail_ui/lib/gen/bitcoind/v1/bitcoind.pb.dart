//
//  Generated code. Do not modify.
//  source: bitcoind/v1/bitcoind.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../google/protobuf/timestamp.pb.dart' as $5;

class ListRecentBlocksRequest extends $pb.GeneratedMessage {
  factory ListRecentBlocksRequest({
    $fixnum.Int64? count,
  }) {
    final $result = create();
    if (count != null) {
      $result.count = count;
    }
    return $result;
  }
  ListRecentBlocksRequest._() : super();
  factory ListRecentBlocksRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListRecentBlocksRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListRecentBlocksRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'bitcoind.v1'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'count')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListRecentBlocksRequest clone() => ListRecentBlocksRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListRecentBlocksRequest copyWith(void Function(ListRecentBlocksRequest) updates) => super.copyWith((message) => updates(message as ListRecentBlocksRequest)) as ListRecentBlocksRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListRecentBlocksRequest create() => ListRecentBlocksRequest._();
  ListRecentBlocksRequest createEmptyInstance() => create();
  static $pb.PbList<ListRecentBlocksRequest> createRepeated() => $pb.PbList<ListRecentBlocksRequest>();
  @$core.pragma('dart2js:noInline')
  static ListRecentBlocksRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListRecentBlocksRequest>(create);
  static ListRecentBlocksRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get count => $_getI64(0);
  @$pb.TagNumber(1)
  set count($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearCount() => clearField(1);
}

class Block extends $pb.GeneratedMessage {
  factory Block({
    $5.Timestamp? blockTime,
    $core.int? blockHeight,
    $core.String? hash,
  }) {
    final $result = create();
    if (blockTime != null) {
      $result.blockTime = blockTime;
    }
    if (blockHeight != null) {
      $result.blockHeight = blockHeight;
    }
    if (hash != null) {
      $result.hash = hash;
    }
    return $result;
  }
  Block._() : super();
  factory Block.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Block.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Block', package: const $pb.PackageName(_omitMessageNames ? '' : 'bitcoind.v1'), createEmptyInstance: create)
    ..aOM<$5.Timestamp>(1, _omitFieldNames ? '' : 'blockTime', subBuilder: $5.Timestamp.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'blockHeight', $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'hash')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Block clone() => Block()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Block copyWith(void Function(Block) updates) => super.copyWith((message) => updates(message as Block)) as Block;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Block create() => Block._();
  Block createEmptyInstance() => create();
  static $pb.PbList<Block> createRepeated() => $pb.PbList<Block>();
  @$core.pragma('dart2js:noInline')
  static Block getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Block>(create);
  static Block? _defaultInstance;

  @$pb.TagNumber(1)
  $5.Timestamp get blockTime => $_getN(0);
  @$pb.TagNumber(1)
  set blockTime($5.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBlockTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlockTime() => clearField(1);
  @$pb.TagNumber(1)
  $5.Timestamp ensureBlockTime() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get blockHeight => $_getIZ(1);
  @$pb.TagNumber(2)
  set blockHeight($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBlockHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearBlockHeight() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get hash => $_getSZ(2);
  @$pb.TagNumber(3)
  set hash($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHash() => $_has(2);
  @$pb.TagNumber(3)
  void clearHash() => clearField(3);
}

class ListRecentBlocksResponse extends $pb.GeneratedMessage {
  factory ListRecentBlocksResponse({
    $core.Iterable<Block>? recentBlocks,
  }) {
    final $result = create();
    if (recentBlocks != null) {
      $result.recentBlocks.addAll(recentBlocks);
    }
    return $result;
  }
  ListRecentBlocksResponse._() : super();
  factory ListRecentBlocksResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListRecentBlocksResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListRecentBlocksResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'bitcoind.v1'), createEmptyInstance: create)
    ..pc<Block>(4, _omitFieldNames ? '' : 'recentBlocks', $pb.PbFieldType.PM, subBuilder: Block.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListRecentBlocksResponse clone() => ListRecentBlocksResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListRecentBlocksResponse copyWith(void Function(ListRecentBlocksResponse) updates) => super.copyWith((message) => updates(message as ListRecentBlocksResponse)) as ListRecentBlocksResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListRecentBlocksResponse create() => ListRecentBlocksResponse._();
  ListRecentBlocksResponse createEmptyInstance() => create();
  static $pb.PbList<ListRecentBlocksResponse> createRepeated() => $pb.PbList<ListRecentBlocksResponse>();
  @$core.pragma('dart2js:noInline')
  static ListRecentBlocksResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListRecentBlocksResponse>(create);
  static ListRecentBlocksResponse? _defaultInstance;

  @$pb.TagNumber(4)
  $core.List<Block> get recentBlocks => $_getList(0);
}

class ListRecentTransactionsRequest extends $pb.GeneratedMessage {
  factory ListRecentTransactionsRequest({
    $fixnum.Int64? count,
  }) {
    final $result = create();
    if (count != null) {
      $result.count = count;
    }
    return $result;
  }
  ListRecentTransactionsRequest._() : super();
  factory ListRecentTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListRecentTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListRecentTransactionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'bitcoind.v1'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'count')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListRecentTransactionsRequest clone() => ListRecentTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListRecentTransactionsRequest copyWith(void Function(ListRecentTransactionsRequest) updates) => super.copyWith((message) => updates(message as ListRecentTransactionsRequest)) as ListRecentTransactionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListRecentTransactionsRequest create() => ListRecentTransactionsRequest._();
  ListRecentTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<ListRecentTransactionsRequest> createRepeated() => $pb.PbList<ListRecentTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListRecentTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListRecentTransactionsRequest>(create);
  static ListRecentTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get count => $_getI64(0);
  @$pb.TagNumber(1)
  set count($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearCount() => clearField(1);
}

class ListRecentTransactionsResponse extends $pb.GeneratedMessage {
  factory ListRecentTransactionsResponse({
    $core.Iterable<RecentTransaction>? transactions,
  }) {
    final $result = create();
    if (transactions != null) {
      $result.transactions.addAll(transactions);
    }
    return $result;
  }
  ListRecentTransactionsResponse._() : super();
  factory ListRecentTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListRecentTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListRecentTransactionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'bitcoind.v1'), createEmptyInstance: create)
    ..pc<RecentTransaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: RecentTransaction.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListRecentTransactionsResponse clone() => ListRecentTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListRecentTransactionsResponse copyWith(void Function(ListRecentTransactionsResponse) updates) => super.copyWith((message) => updates(message as ListRecentTransactionsResponse)) as ListRecentTransactionsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListRecentTransactionsResponse create() => ListRecentTransactionsResponse._();
  ListRecentTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<ListRecentTransactionsResponse> createRepeated() => $pb.PbList<ListRecentTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListRecentTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListRecentTransactionsResponse>(create);
  static ListRecentTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<RecentTransaction> get transactions => $_getList(0);
}

class RecentTransaction extends $pb.GeneratedMessage {
  factory RecentTransaction({
    $core.int? virtualSize,
    $5.Timestamp? time,
    $core.String? txid,
    $fixnum.Int64? feeSats,
    Block? confirmedInBlock,
  }) {
    final $result = create();
    if (virtualSize != null) {
      $result.virtualSize = virtualSize;
    }
    if (time != null) {
      $result.time = time;
    }
    if (txid != null) {
      $result.txid = txid;
    }
    if (feeSats != null) {
      $result.feeSats = feeSats;
    }
    if (confirmedInBlock != null) {
      $result.confirmedInBlock = confirmedInBlock;
    }
    return $result;
  }
  RecentTransaction._() : super();
  factory RecentTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecentTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RecentTransaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'bitcoind.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'virtualSize', $pb.PbFieldType.OU3)
    ..aOM<$5.Timestamp>(2, _omitFieldNames ? '' : 'time', subBuilder: $5.Timestamp.create)
    ..aOS(3, _omitFieldNames ? '' : 'txid')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'feeSats', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<Block>(5, _omitFieldNames ? '' : 'confirmedInBlock', subBuilder: Block.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RecentTransaction clone() => RecentTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RecentTransaction copyWith(void Function(RecentTransaction) updates) => super.copyWith((message) => updates(message as RecentTransaction)) as RecentTransaction;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecentTransaction create() => RecentTransaction._();
  RecentTransaction createEmptyInstance() => create();
  static $pb.PbList<RecentTransaction> createRepeated() => $pb.PbList<RecentTransaction>();
  @$core.pragma('dart2js:noInline')
  static RecentTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecentTransaction>(create);
  static RecentTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get virtualSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set virtualSize($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVirtualSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearVirtualSize() => clearField(1);

  @$pb.TagNumber(2)
  $5.Timestamp get time => $_getN(1);
  @$pb.TagNumber(2)
  set time($5.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearTime() => clearField(2);
  @$pb.TagNumber(2)
  $5.Timestamp ensureTime() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get txid => $_getSZ(2);
  @$pb.TagNumber(3)
  set txid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTxid() => $_has(2);
  @$pb.TagNumber(3)
  void clearTxid() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get feeSats => $_getI64(3);
  @$pb.TagNumber(4)
  set feeSats($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFeeSats() => $_has(3);
  @$pb.TagNumber(4)
  void clearFeeSats() => clearField(4);

  @$pb.TagNumber(5)
  Block get confirmedInBlock => $_getN(4);
  @$pb.TagNumber(5)
  set confirmedInBlock(Block v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasConfirmedInBlock() => $_has(4);
  @$pb.TagNumber(5)
  void clearConfirmedInBlock() => clearField(5);
  @$pb.TagNumber(5)
  Block ensureConfirmedInBlock() => $_ensure(4);
}

class GetBlockchainInfoResponse extends $pb.GeneratedMessage {
  factory GetBlockchainInfoResponse({
    $core.String? chain,
    $core.int? blocks,
    $core.int? headers,
    $core.String? bestBlockHash,
    $core.bool? initialBlockDownload,
  }) {
    final $result = create();
    if (chain != null) {
      $result.chain = chain;
    }
    if (blocks != null) {
      $result.blocks = blocks;
    }
    if (headers != null) {
      $result.headers = headers;
    }
    if (bestBlockHash != null) {
      $result.bestBlockHash = bestBlockHash;
    }
    if (initialBlockDownload != null) {
      $result.initialBlockDownload = initialBlockDownload;
    }
    return $result;
  }
  GetBlockchainInfoResponse._() : super();
  factory GetBlockchainInfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBlockchainInfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetBlockchainInfoResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'bitcoind.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'chain')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'blocks', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'headers', $pb.PbFieldType.OU3)
    ..aOS(4, _omitFieldNames ? '' : 'bestBlockHash')
    ..aOB(8, _omitFieldNames ? '' : 'initialBlockDownload')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBlockchainInfoResponse clone() => GetBlockchainInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBlockchainInfoResponse copyWith(void Function(GetBlockchainInfoResponse) updates) => super.copyWith((message) => updates(message as GetBlockchainInfoResponse)) as GetBlockchainInfoResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBlockchainInfoResponse create() => GetBlockchainInfoResponse._();
  GetBlockchainInfoResponse createEmptyInstance() => create();
  static $pb.PbList<GetBlockchainInfoResponse> createRepeated() => $pb.PbList<GetBlockchainInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBlockchainInfoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBlockchainInfoResponse>(create);
  static GetBlockchainInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get chain => $_getSZ(0);
  @$pb.TagNumber(1)
  set chain($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChain() => $_has(0);
  @$pb.TagNumber(1)
  void clearChain() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get blocks => $_getIZ(1);
  @$pb.TagNumber(2)
  set blocks($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBlocks() => $_has(1);
  @$pb.TagNumber(2)
  void clearBlocks() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get headers => $_getIZ(2);
  @$pb.TagNumber(3)
  set headers($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHeaders() => $_has(2);
  @$pb.TagNumber(3)
  void clearHeaders() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get bestBlockHash => $_getSZ(3);
  @$pb.TagNumber(4)
  set bestBlockHash($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBestBlockHash() => $_has(3);
  @$pb.TagNumber(4)
  void clearBestBlockHash() => clearField(4);

  @$pb.TagNumber(8)
  $core.bool get initialBlockDownload => $_getBF(4);
  @$pb.TagNumber(8)
  set initialBlockDownload($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(8)
  $core.bool hasInitialBlockDownload() => $_has(4);
  @$pb.TagNumber(8)
  void clearInitialBlockDownload() => clearField(8);
}

class Peer extends $pb.GeneratedMessage {
  factory Peer({
    $core.int? id,
    $core.String? addr,
    $core.int? syncedBlocks,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (addr != null) {
      $result.addr = addr;
    }
    if (syncedBlocks != null) {
      $result.syncedBlocks = syncedBlocks;
    }
    return $result;
  }
  Peer._() : super();
  factory Peer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Peer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Peer', package: const $pb.PackageName(_omitMessageNames ? '' : 'bitcoind.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'addr')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'syncedBlocks', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Peer clone() => Peer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Peer copyWith(void Function(Peer) updates) => super.copyWith((message) => updates(message as Peer)) as Peer;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Peer create() => Peer._();
  Peer createEmptyInstance() => create();
  static $pb.PbList<Peer> createRepeated() => $pb.PbList<Peer>();
  @$core.pragma('dart2js:noInline')
  static Peer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Peer>(create);
  static Peer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get addr => $_getSZ(1);
  @$pb.TagNumber(2)
  set addr($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAddr() => $_has(1);
  @$pb.TagNumber(2)
  void clearAddr() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get syncedBlocks => $_getIZ(2);
  @$pb.TagNumber(3)
  set syncedBlocks($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSyncedBlocks() => $_has(2);
  @$pb.TagNumber(3)
  void clearSyncedBlocks() => clearField(3);
}

class ListPeersResponse extends $pb.GeneratedMessage {
  factory ListPeersResponse({
    $core.Iterable<Peer>? peers,
  }) {
    final $result = create();
    if (peers != null) {
      $result.peers.addAll(peers);
    }
    return $result;
  }
  ListPeersResponse._() : super();
  factory ListPeersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPeersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListPeersResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'bitcoind.v1'), createEmptyInstance: create)
    ..pc<Peer>(1, _omitFieldNames ? '' : 'peers', $pb.PbFieldType.PM, subBuilder: Peer.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPeersResponse clone() => ListPeersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPeersResponse copyWith(void Function(ListPeersResponse) updates) => super.copyWith((message) => updates(message as ListPeersResponse)) as ListPeersResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPeersResponse create() => ListPeersResponse._();
  ListPeersResponse createEmptyInstance() => create();
  static $pb.PbList<ListPeersResponse> createRepeated() => $pb.PbList<ListPeersResponse>();
  @$core.pragma('dart2js:noInline')
  static ListPeersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPeersResponse>(create);
  static ListPeersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Peer> get peers => $_getList(0);
}

class EstimateSmartFeeRequest extends $pb.GeneratedMessage {
  factory EstimateSmartFeeRequest({
    $fixnum.Int64? confTarget,
  }) {
    final $result = create();
    if (confTarget != null) {
      $result.confTarget = confTarget;
    }
    return $result;
  }
  EstimateSmartFeeRequest._() : super();
  factory EstimateSmartFeeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EstimateSmartFeeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EstimateSmartFeeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'bitcoind.v1'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'confTarget')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EstimateSmartFeeRequest clone() => EstimateSmartFeeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EstimateSmartFeeRequest copyWith(void Function(EstimateSmartFeeRequest) updates) => super.copyWith((message) => updates(message as EstimateSmartFeeRequest)) as EstimateSmartFeeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EstimateSmartFeeRequest create() => EstimateSmartFeeRequest._();
  EstimateSmartFeeRequest createEmptyInstance() => create();
  static $pb.PbList<EstimateSmartFeeRequest> createRepeated() => $pb.PbList<EstimateSmartFeeRequest>();
  @$core.pragma('dart2js:noInline')
  static EstimateSmartFeeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EstimateSmartFeeRequest>(create);
  static EstimateSmartFeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get confTarget => $_getI64(0);
  @$pb.TagNumber(1)
  set confTarget($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasConfTarget() => $_has(0);
  @$pb.TagNumber(1)
  void clearConfTarget() => clearField(1);
}

class EstimateSmartFeeResponse extends $pb.GeneratedMessage {
  factory EstimateSmartFeeResponse({
    $core.double? feeRate,
    $core.Iterable<$core.String>? errors,
  }) {
    final $result = create();
    if (feeRate != null) {
      $result.feeRate = feeRate;
    }
    if (errors != null) {
      $result.errors.addAll(errors);
    }
    return $result;
  }
  EstimateSmartFeeResponse._() : super();
  factory EstimateSmartFeeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EstimateSmartFeeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EstimateSmartFeeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'bitcoind.v1'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'feeRate', $pb.PbFieldType.OD)
    ..pPS(2, _omitFieldNames ? '' : 'errors')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EstimateSmartFeeResponse clone() => EstimateSmartFeeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EstimateSmartFeeResponse copyWith(void Function(EstimateSmartFeeResponse) updates) => super.copyWith((message) => updates(message as EstimateSmartFeeResponse)) as EstimateSmartFeeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EstimateSmartFeeResponse create() => EstimateSmartFeeResponse._();
  EstimateSmartFeeResponse createEmptyInstance() => create();
  static $pb.PbList<EstimateSmartFeeResponse> createRepeated() => $pb.PbList<EstimateSmartFeeResponse>();
  @$core.pragma('dart2js:noInline')
  static EstimateSmartFeeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EstimateSmartFeeResponse>(create);
  static EstimateSmartFeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get feeRate => $_getN(0);
  @$pb.TagNumber(1)
  set feeRate($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFeeRate() => $_has(0);
  @$pb.TagNumber(1)
  void clearFeeRate() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get errors => $_getList(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
