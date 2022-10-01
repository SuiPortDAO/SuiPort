import 'package:wallet/api/api_service.dart';
import 'package:wallet/api/get_txn_digests_response.dart';
import 'package:wallet/api/sui_object_info_response.dart';
import 'package:wallet/api/sui_request.dart';
import 'package:wallet/utils/json.dart';

import 'get_object_data_response.dart';

class SuiApi {
  final ApiService _apiService = ApiService('https://fullnode.devnet.sui.io/');

  Future<List<SuiObjectInfo>?> getObjectsOwnedByAddress(String address) async {
    final response = await _apiService.post('/',
        SuiRequest(method: 'sui_getObjectsOwnedByAddress', params: [address]));
    return SuiObjectInfoReponse.fromJson(response.data).result;
  }

  Future<List<SuiObject?>> getObjectBatch(List<String?>? objectIds) async {
    final response = await _apiService.post(
        '/',
        objectIds
            ?.map((String? objectId) =>
                SuiRequest(method: 'sui_getObject', params: [objectId ?? '']))
            .toList());
    return response.data
        .map((e) => GetObjectDataResponse.fromJson(e).result?.details)
        .cast<SuiObject>()
        .toList();
  }

  Future<List<SuiTansaction>> getTransactionsForAddress(address) async {
    final List<SuiTansaction> tansactions = [];
    final List<String> digests = [];
    final List<num> seq = [];

    (await _apiService.post('/', [
      SuiRequest(method: 'sui_getTransactionsToAddress', params: [address]),
      SuiRequest(method: 'sui_getTransactionsFromAddress', params: [address])
    ]))
        .data
        .forEach((e) => GetTxnDigestsResponse.fromJson(e).result?.forEach((e) {
              digests.add(e[1]);
              seq.add(e[0]);
            }));

    if (digests.isEmpty) {
      return tansactions;
    }

    (await _apiService.post(
            '/',
            digests
                .map((digest) =>
                    SuiRequest(method: 'sui_getTransaction', params: [digest]))
                .toList()))
        .data
        .forEach((json) {
      // flat
      // how to performance
      // TODO
      // filter
      final gasSummary = JSON.resolve(
          json: json, path: 'result.effects.gasUsed', defaultValue: {});
      final from = JSON.resolve(
          json: json, path: 'result.certificate.data.sender', defaultValue: '');
      final error = JSON.resolve(
          json: json, path: 'result.effects.status.error', defaultValue: '');
      final status = JSON.resolve(
          json: json, path: 'result.effects.status.status', defaultValue: '');
      final timestampMs = JSON.resolve(
          json: json, path: 'result.timestamp_ms', defaultValue: 0);
      final txGas = (gasSummary['computationCost'] ?? 0) +
          (gasSummary['storageCost'] ?? 0) -
          (gasSummary['storageRebate'] ?? 0);

      final transactionDigest = JSON.resolve(
          json: json,
          path: 'result.certificate.transactionDigest',
          defaultValue: '');

      final txn = JSON.resolve(
          json: json,
          path: 'result.certificate.data.transactions.0',
          defaultValue: {});

      var txKind = '';
      var amount = 0;
      var recipient = '';
      if (txn.keys.first is String) {
        txKind = txn.keys.first;
        amount = JSON.resolve(
            json: json,
            path: 'result.certificate.data.transactions.0.$txKind.amount',
            defaultValue: 0);

        recipient = JSON.resolve(
            json: json,
            path: 'result.certificate.data.transactions.0.$txKind.recipient',
            defaultValue: '');
      }

      tansactions.add(
        SuiTansaction(
          seq: seq[digests.indexOf(transactionDigest)],
          txId: transactionDigest,
          status: status,
          txGas: txGas,
          kind: txKind,
          from: from,
          error: error,
          timestampMs: timestampMs,
          isSender: from == address,
          amount: amount,
          recipient: recipient,
        ),
      );
    });

    return tansactions;
  }
}

class SuiTansaction {
  final num seq;
  final String txId;
  final String status;
  final num txGas;
  final String kind;
  final String from;
  final String error;
  final num timestampMs;
  final bool isSender;
  final num amount;
  final String recipient;
  SuiTansaction(
      {required this.seq,
      required this.txId,
      required this.status,
      required this.txGas,
      required this.kind,
      required this.from,
      required this.error,
      required this.timestampMs,
      required this.isSender,
      required this.amount,
      required this.recipient});
}
