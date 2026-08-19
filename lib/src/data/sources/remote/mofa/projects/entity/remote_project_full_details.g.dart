// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_project_full_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteProjectFullDetails _$RemoteProjectFullDetailsFromJson(
        Map<String, dynamic> json) =>
    RemoteProjectFullDetails(
      project: json['project'] == null
          ? const RemoteGetAllProjects()
          : RemoteGetAllProjects.fromJson(
              json['project'] as Map<String, dynamic>),
      deliverables: (json['deliverables'] as List<dynamic>?)
              ?.map((e) => RemoteDelivery.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      milestones: (json['milestones'] as List<dynamic>?)
              ?.map((e) => RemoteMilestones.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      issues: (json['issues'] as List<dynamic>?)
              ?.map((e) => RemoteIssues.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      risks: (json['risks'] as List<dynamic>?)
              ?.map((e) => RemoteRisks.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      compliance: (json['compliance'] as List<dynamic>?)
              ?.map((e) => RemoteCompliance.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteProjectFullDetailsToJson(
        RemoteProjectFullDetails instance) =>
    <String, dynamic>{
      'project': instance.project,
      'deliverables': instance.deliverables,
      'milestones': instance.milestones,
      'issues': instance.issues,
      'risks': instance.risks,
      'compliance': instance.compliance,
    };
