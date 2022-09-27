import 'package:wallet/api/api_service.dart';
import 'package:wallet/api/sui_object_info_response.dart';
import 'package:wallet/api/sui_request.dart';

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
}
