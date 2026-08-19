// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_stratygies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteStratygies _$RemoteStratygiesFromJson(Map<String, dynamic> json) =>
    RemoteStratygies(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      startDate: json['startDate'] as String? ?? '',
      endDate: json['endDate'] as String? ?? '',
      strategyLevelName: json['strategyLevelName'] as String? ?? '',
      creationDate: json['creationDate'] as String? ?? '',
      fullUrl: json['fullUrl'] as String? ?? '',
      description: json['description'] as String? ?? '',
      vision: json['vision'] as String? ?? '',
      mission: json['mission'] as String? ?? '',
      strategyStatusStr: json['strategyStatusStr'] as String? ?? '',
      strategyFrameworkStr: json['strategyFrameworkStr'] as String? ?? '',
      strategyPerformanceModelStr:
          json['strategyPerformanceModelStr'] as String? ?? '',
      objectivesCount: (json['objectivesCount'] as num?)?.toInt() ?? 0,
      initiativesCount: (json['initiativesCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RemoteStratygiesToJson(RemoteStratygies instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'strategyLevelName': instance.strategyLevelName,
      'creationDate': instance.creationDate,
      'fullUrl': instance.fullUrl,
      'description': instance.description,
      'vision': instance.vision,
      'mission': instance.mission,
      'strategyStatusStr': instance.strategyStatusStr,
      'strategyFrameworkStr': instance.strategyFrameworkStr,
      'strategyPerformanceModelStr': instance.strategyPerformanceModelStr,
      'objectivesCount': instance.objectivesCount,
      'initiativesCount': instance.initiativesCount,
    };
