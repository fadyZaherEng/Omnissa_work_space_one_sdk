// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_home_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteHomeStatistics _$RemoteHomeStatisticsFromJson(
        Map<String, dynamic> json) =>
    RemoteHomeStatistics(
      title: json['title'] as String? ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map(
                  (e) => RemoteStaticsItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      visible: json['visible'] as bool? ?? false,
    );

Map<String, dynamic> _$RemoteHomeStatisticsToJson(
        RemoteHomeStatistics instance) =>
    <String, dynamic>{
      'title': instance.title,
      'items': instance.items,
      'visible': instance.visible,
    };
