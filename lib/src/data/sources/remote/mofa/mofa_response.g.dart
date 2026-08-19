// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mofa_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MofaResponse<T> _$MofaResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    MofaResponse<T>(
      statusCode: (json['errorCode'] as num?)?.toInt(),
      requestId: json['requestId'] as String?,
      error: json['errorMessage'] as String?,
      check: json['check'] as bool?,
      responseMessage: json['responseMessage'] as String?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$MofaResponseToJson<T>(
  MofaResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'errorCode': instance.statusCode,
      'requestId': instance.requestId,
      'errorMessage': instance.error,
      'check': instance.check,
      'responseMessage': instance.responseMessage,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
