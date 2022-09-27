class GetTxnDigestsResponse {
  String? jsonrpc;
  List<List>? result;
  String? id;

  GetTxnDigestsResponse({this.jsonrpc, this.result, this.id});

  GetTxnDigestsResponse.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    if (json['result'] != null) {
      result = <List>[];
      json['result'].forEach((v) {
        result!.add(List.castFrom(v));
      });
    }
    id = json['id'];
  }
}
