// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mofa_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MofaRequest<T> _$MofaRequestFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    MofaRequest<T>(
      draw: json['draw'] as String?,
      start: json['start'] as String?,
      length: json['length'] as String?,
      orderColumn: json['orderColumn'] as String?,
      sortColumn: json['sortColumn'] as String?,
      sortColumnDirection: json['sortColumnDirection'] as String?,
      columnDirection: json['columnDirection'] as String?,
      pageSize: (json['pageSize'] as num?)?.toInt(),
      skip: (json['skip'] as num?)?.toInt(),
      searchValue: json['searchValue'] as String?,
      searchFilterDefinition: json['searchFilterDefinition'] as String?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$MofaRequestToJson<T>(
  MofaRequest<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'draw': instance.draw,
      'start': instance.start,
      'length': instance.length,
      'orderColumn': instance.orderColumn,
      'sortColumn': instance.sortColumn,
      'sortColumnDirection': instance.sortColumnDirection,
      'columnDirection': instance.columnDirection,
      'pageSize': instance.pageSize,
      'skip': instance.skip,
      'searchValue': instance.searchValue,
      'searchFilterDefinition': instance.searchFilterDefinition,
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
