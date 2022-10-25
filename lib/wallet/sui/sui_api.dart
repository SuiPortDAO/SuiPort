import 'package:dio/dio.dart';
import 'package:wallet/common/toast.dart';
import 'package:wallet/utils/format.dart';
import 'package:wallet/utils/json.dart';
import 'package:wallet/wallet/sui/api_service.dart';
import 'package:wallet/wallet/sui/sui_request.dart';

class SuiApi {
  final ApiService _apiService = ApiService('https://fullnode.devnet.sui.io/');

  Future<List<String>> getObjectsOwnedByAddress(String address) async {
    List<String> objectIds = [];
    final response = await _apiService.post('/',
        SuiRequest(method: 'sui_getObjectsOwnedByAddress', params: [address]));
    final result =
        JSON.resolve(json: response.data, path: 'result', defaultValue: []);
    for (var element in result) {
      if (element['objectId'] is String) {
        objectIds.add(element['objectId']);
      }
    }
    return objectIds;
  }

  Future<List<SuiObject>> getObjectBatch(List<String?>? objectIds) async {
    try {
      List<SuiObject> ownedSuiObject = [];
      final response = await _apiService.post(
          '/',
          objectIds
              ?.map((String? objectId) =>
                  SuiRequest(method: 'sui_getObject', params: [objectId ?? '']))
              .toList());
      if (response.data is! List && response.data['error'] is Map) {
        return [];
      }
      response.data.forEach((json) {
        final type = JSON.resolve(
            json: json, path: 'result.details.data.type', defaultValue: '');
        final dataType = JSON.resolve(
            json: json, path: 'result.details.data.dataType', defaultValue: '');
        final hasPublicTransfer = JSON.resolve(
            json: json,
            path: 'result.details.data.has_public_transfer',
            defaultValue: false);
        final fields = JSON.resolve(
            json: json, path: 'result.details.data.fields', defaultValue: {});

        ownedSuiObject.add(SuiObject(
            type: type,
            dataType: dataType,
            hasPublicTransfer: hasPublicTransfer,
            fields: fields));
      });
      return ownedSuiObject;
    } on DioError catch (e) {
      showError('Network Error', (e.response ?? e.message).toString());
      return [];
    } on Error catch (e) {
      showError('getObjectBatch Error', e.toString());
      return [];
    }
  }

  SuiTansaction transformTransaction(json, address) {
    final gasSummary = JSON
        .resolve(json: json, path: 'result.effects.gasUsed', defaultValue: {});
    final from = JSON.resolve(
        json: json, path: 'result.certificate.data.sender', defaultValue: '');
    final error = JSON.resolve(
        json: json, path: 'result.effects.status.error', defaultValue: '');
    final status = JSON.resolve(
        json: json, path: 'result.effects.status.status', defaultValue: '');
    final timestampMs =
        JSON.resolve(json: json, path: 'result.timestamp_ms', defaultValue: 0);
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

    return SuiTansaction(
      // seq: seq[digests.indexOf(transactionDigest)],
      txId: transactionDigest,
      status: status,
      txGas: txGas,
      kind: txKind,
      from: from,
      error: error,
      timestampMs: timestampMs,
      isSender: addressStandard(from) == addressStandard(address),
      amount: amount,
      recipient: recipient,
    );
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
        .forEach((json) {
      final result = JSON.resolve(json: json, path: 'result', defaultValue: []);
      for (var e in result) {
        if (!seq.contains(e[0])) {
          digests.add(e[1]);
          seq.add(e[0]);
        }
      }
    });

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
      tansactions.add(transformTransaction(json, address));
    });
    tansactions.sort((a, b) => b.timestampMs - a.timestampMs);
    return tansactions;
  }

  suiTransferSui(List<dynamic> params) async {
    return await _apiService.post(
        '/', SuiRequest(method: 'sui_transferSui', params: params));
  }

  suiMoveCall(List<dynamic> params) async {
    return await _apiService.post(
        '/', SuiRequest(method: 'sui_moveCall', params: params));
  }

  Future<SuiTansaction> suiExecuteTransaction(
      String address, List<dynamic> params) async {
    final response = await _apiService.post(
        '/', SuiRequest(method: 'sui_executeTransaction', params: params));

    return transformTransaction(response.data, address);
  }
}

class SuiObject {
  final String type;
  final String dataType;
  final bool hasPublicTransfer;
  final Map<dynamic, dynamic> fields;
  SuiObject(
      {required this.type,
      required this.dataType,
      required this.hasPublicTransfer,
      required this.fields});
}

class SuiTansaction {
  // final num seq;
  final String txId;
  final String status;
  final num txGas;
  final String kind;
  final String from;
  final String error;
  final int timestampMs;
  final bool isSender;
  final num amount;
  final String recipient;
  SuiTansaction(
      {
      // required this.seq,
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
