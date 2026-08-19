// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remore_milstone_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteMilstoneDetails _$RemoteMilstoneDetailsFromJson(
        Map<String, dynamic> json) =>
    RemoteMilstoneDetails(
      id: json['id'] as String?,
      name: json['name'] as String?,
      project: json['project'] == null
          ? null
          : RemoteMilstoneDetailsProject.fromJson(
              json['project'] as Map<String, dynamic>),
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      isOperationalTask: json['isOperationalTask'] as bool?,
      duration: (json['duration'] as num?)?.toInt(),
      percentDone: json['percentDone'],
      baselineStartDate: json['baselineStartDate'] as String?,
      baselineEndDate: json['baselineEndDate'] as String?,
      weight: (json['weight'] as num?)?.toInt(),
      taskOwnerStr: json['taskOwnerStr'],
      requestedDepartmentStr: json['requestedDepartmentStr'],
      assignedDepartmentStr: json['assignedDepartmentStr'],
      note: json['note'],
      assignments: (json['assignments'] as List<dynamic>?)
          ?.map((e) => RemoteAssignments.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RemoteMilstoneDetailsToJson(
        RemoteMilstoneDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'project': instance.project,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'isOperationalTask': instance.isOperationalTask,
      'duration': instance.duration,
      'percentDone': instance.percentDone,
      'baselineStartDate': instance.baselineStartDate,
      'baselineEndDate': instance.baselineEndDate,
      'weight': instance.weight,
      'taskOwnerStr': instance.taskOwnerStr,
      'requestedDepartmentStr': instance.requestedDepartmentStr,
      'assignedDepartmentStr': instance.assignedDepartmentStr,
      'note': instance.note,
      'assignments': instance.assignments,
    };

RemoteMilstoneDetailsProject _$RemoteMilstoneDetailsProjectFromJson(
        Map<String, dynamic> json) =>
    RemoteMilstoneDetailsProject(
      projectName: json['projectName'] as String?,
      projectManagerStr: json['projectManagerStr'] as String?,
    );

Map<String, dynamic> _$RemoteMilstoneDetailsProjectToJson(
        RemoteMilstoneDetailsProject instance) =>
    <String, dynamic>{
      'projectName': instance.projectName,
      'projectManagerStr': instance.projectManagerStr,
    };
