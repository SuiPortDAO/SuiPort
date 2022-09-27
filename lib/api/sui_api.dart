import 'package:wallet/api/api_service.dart';
import 'package:wallet/api/get_txn_digests_response.dart';
import 'package:wallet/api/sui_object_info_response.dart';
import 'package:wallet/api/sui_request.dart';
import 'package:wallet/api/sui_transaction_response.dart';

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

  getTransactionsForAddress(address) async {
    final tansactions = [];
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

    (await _apiService.post(
            '/',
            digests
                .map((digest) =>
                    SuiRequest(method: 'sui_getTransaction', params: [digest]))
                .toList()))
        .data
        .forEach((e) {
      final txEff = SuiTransactionResponse.fromJson(e).result;
      final res = txEff?.certificate;
      final txns = res?.data?.transactions;
      if (txns?.isNotEmpty == true) {
        final txn = txns?[0];
        final txKind = 'TransferSui';
        final gasSummary = txEff?.effects?.gasUsed;
        final txGas = gasSummary?.computationCost ??
            0 +
                (gasSummary?.storageCost ?? 0) -
                (gasSummary?.storageRebate ?? 0);
        tansactions.add({
          'status': txEff?.effects?.status,
          'txGas': txGas,
          'kind': txKind,
          'from': res?.data?.sender,
          // 'error': txEff?.effects?.status?.error
          'timestampMs': txEff?.timestampMs,
          'isSender': false
        });
      }
    });

    print(tansactions);
  }
}
