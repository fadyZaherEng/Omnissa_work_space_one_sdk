// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_milstone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteMilestones _$RemoteMilestonesFromJson(Map<String, dynamic> json) =>
    RemoteMilestones(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      startDate: json['startDate'] as String? ?? '',
      endDate: json['endDate'] as String? ?? '',
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      percentDone: (json['percentDone'] as num?)?.toInt() ?? 0,
      baselineStartDate: json['baselineStartDate'] as String? ?? '',
      baselineEndDate: json['baselineEndDate'] as String? ?? '',
      weight: (json['weight'] as num?)?.toInt() ?? 0,
      creationDate: json['creationDate'] as String? ?? '',
      projectCardStatus: (json['projectCardStatus'] as num?)?.toInt() ?? 0,
      parentName: json['parentName'] as String? ?? '',
      projectCardStatusStr: json['projectCardStatusStr'] == null
          ? const RemoteProjectStatusColor()
          : RemoteProjectStatusColor.fromJson(
              json['projectCardStatusStr'] as Map<String, dynamic>),
      statusColor: json['statusColor'] == null
          ? const RemoteProjectStatusColor()
          : RemoteProjectStatusColor.fromJson(
              json['statusColor'] as Map<String, dynamic>),
      assignments: (json['assignments'] as List<dynamic>?)
              ?.map(
                  (e) => RemoteAssignments.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      note: json['note'] as String? ?? '',
    );

Map<String, dynamic> _$RemoteMilestonesToJson(RemoteMilestones instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parentName': instance.parentName,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'duration': instance.duration,
      'percentDone': instance.percentDone,
      'baselineStartDate': instance.baselineStartDate,
      'baselineEndDate': instance.baselineEndDate,
      'weight': instance.weight,
      'creationDate': instance.creationDate,
      'projectCardStatus': instance.projectCardStatus,
      'projectCardStatusStr': instance.projectCardStatusStr,
      'statusColor': instance.statusColor,
      'assignments': instance.assignments,
      'note': instance.note,
    };

RemoteAssignments _$RemoteAssignmentsFromJson(Map<String, dynamic> json) =>
    RemoteAssignments(
      resourceName: json['resourceName'] as String? ?? '',
      id: json['id'] as String? ?? '',
      taskId: json['taskId'] as String? ?? '',
      resourceId: json['resourceId'] as String? ?? '',
      units: (json['units'] as num?)?.toInt() ?? 0,
      assignmentHistory:
          json['assignmentHistory'] as List<dynamic>? ?? const [],
    );

Map<String, dynamic> _$RemoteAssignmentsToJson(RemoteAssignments instance) =>
    <String, dynamic>{
      'resourceName': instance.resourceName,
      'id': instance.id,
      'taskId': instance.taskId,
      'resourceId': instance.resourceId,
      'units': instance.units,
      'assignmentHistory': instance.assignmentHistory,
    };
