// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sui_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuiRequest _$SuiRequestFromJson(Map<String, dynamic> json) => SuiRequest(
      method: json['method'] as String,
      params:
          (json['params'] as List<dynamic>).map((e) => e as String).toList(),
    )
      ..id = json['id'] as String
      ..jsonrpc = json['jsonrpc'] as String;

Map<String, dynamic> _$SuiRequestToJson(SuiRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jsonrpc': instance.jsonrpc,
      'method': instance.method,
      'params': instance.params,
    };
