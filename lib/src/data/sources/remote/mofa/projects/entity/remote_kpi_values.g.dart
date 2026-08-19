// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_kpi_values.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteKpiValues _$RemoteKpiValuesFromJson(Map<String, dynamic> json) =>
    RemoteKpiValues(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      value: (json['value'] as num?)?.toInt() ?? 0,
      color: json['color'] as String? ?? '',
    );

Map<String, dynamic> _$RemoteKpiValuesToJson(RemoteKpiValues instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'value': instance.value,
      'color': instance.color,
    };
