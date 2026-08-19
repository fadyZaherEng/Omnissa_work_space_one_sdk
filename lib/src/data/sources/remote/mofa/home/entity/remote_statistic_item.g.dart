// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_statistic_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteStaticsItem _$RemoteStaticsItemFromJson(Map<String, dynamic> json) =>
    RemoteStaticsItem(
      label: json['label'] as String? ?? "",
      color: json['color'] as String? ?? "",
      count: (json['count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RemoteStaticsItemToJson(RemoteStaticsItem instance) =>
    <String, dynamic>{
      'label': instance.label,
      'color': instance.color,
      'count': instance.count,
    };
