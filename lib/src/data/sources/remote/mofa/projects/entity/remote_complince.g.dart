// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_complince.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCompliance _$RemoteComplianceFromJson(Map<String, dynamic> json) =>
    RemoteCompliance(
      id: json['id'] as String? ?? "",
      taskName: json['taskName'] as String? ?? "",
      activityName: json['activityName'] as String? ?? "",
      processName: json['processName'] as String? ?? "",
      phaseName: json['phaseName'] as String? ?? "",
      stageName: json['stageName'] as String? ?? "",
      mark: (json['mark'] as num?)?.toDouble() ?? 0,
      complianceRateStr: json['complianceRateStr'] as String? ?? "",
      complianceRate: (json['complianceRate'] as num?)?.toInt() ?? 0,
      discoveryDate: json['discoveryDate'] as String? ?? "",
      resolutionDate: json['resolutionDate'] as String? ?? "",
      recommendations: json['recommendations'] as String? ?? "",
      observation: json['observation'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteComplianceToJson(RemoteCompliance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'taskName': instance.taskName,
      'activityName': instance.activityName,
      'processName': instance.processName,
      'phaseName': instance.phaseName,
      'stageName': instance.stageName,
      'mark': instance.mark,
      'complianceRateStr': instance.complianceRateStr,
      'complianceRate': instance.complianceRate,
      'discoveryDate': instance.discoveryDate,
      'resolutionDate': instance.resolutionDate,
      'recommendations': instance.recommendations,
      'observation': instance.observation,
    };
