import 'package:json_annotation/json_annotation.dart';

part 'sui_request.g.dart';

@JsonSerializable(nullable: false)
class SuiRequest {
  String id = '1';
  String jsonrpc = '2.0';
  String method = '';
  List<dynamic> params = [];

  SuiRequest({required this.method, required this.params});

  factory SuiRequest.fromJson(Map<String, dynamic> json) =>
      _$SuiRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SuiRequestToJson(this);
}
