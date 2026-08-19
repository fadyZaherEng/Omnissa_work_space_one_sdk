// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_tasks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteTasks _$RemoteTasksFromJson(Map<String, dynamic> json) => RemoteTasks(
      id: json['id'] as String? ?? "",
      name: json['name'] as String? ?? "",
      project: json['project'] == null
          ? const RemoteProjectName()
          : RemoteProjectName.fromJson(json['project'] as Map<String, dynamic>),
      taskOwnerStr: json['taskOwnerStr'] as String? ?? "",
      startDate: json['startDate'] as String? ?? "",
      endDate: json['endDate'] as String? ?? "",
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      percentDone: (json['percentDone'] as num?)?.toInt() ?? 0,
      baselineStartDate: json['baselineStartDate'] as String? ?? "",
      baselineEndDate: json['baselineEndDate'] as String? ?? "",
      weight: (json['weight'] as num?)?.toInt() ?? 0,
      assignmentId: json['assignmentId'] as String? ?? "",
      draftPercentDone: (json['draftPercentDone'] as num?)?.toInt() ?? 0,
      draftPriority: (json['draftPriority'] as num?)?.toInt() ?? 0,
      draftStatus: (json['draftStatus'] as num?)?.toInt() ?? 0,
      wfStatus: json['wfStatus'] as String? ?? "",
      isOperationalTask: json['isOperationalTask'] as bool? ?? false,
      requestedDepartmentStr: json['requestedDepartmentStr'] as String? ?? "",
      assignedDepartmentStr: json['assignedDepartmentStr'] as String? ?? "",
      wfStatusColor: json['wfStatusColor'] == null
          ? const RemoteWFStatusColor()
          : RemoteWFStatusColor.fromJson(
              json['wfStatusColor'] as Map<String, dynamic>),
      draftStatusObject: json['draftStatusObject'] == null
          ? const RemoteWFStatusColor()
          : RemoteWFStatusColor.fromJson(
              json['draftStatusObject'] as Map<String, dynamic>),
      comment: json['comment'] as String? ?? "",
      taskStatusStr: json['taskStatusStr'] as String? ?? "",
      taskPriorityStr: json['taskPriorityStr'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteTasksToJson(RemoteTasks instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'project': instance.project,
      'taskOwnerStr': instance.taskOwnerStr,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'duration': instance.duration,
      'percentDone': instance.percentDone,
      'baselineStartDate': instance.baselineStartDate,
      'baselineEndDate': instance.baselineEndDate,
      'weight': instance.weight,
      'assignmentId': instance.assignmentId,
      'draftPercentDone': instance.draftPercentDone,
      'draftPriority': instance.draftPriority,
      'draftStatus': instance.draftStatus,
      'wfStatus': instance.wfStatus,
      'comment': instance.comment,
      'isOperationalTask': instance.isOperationalTask,
      'requestedDepartmentStr': instance.requestedDepartmentStr,
      'assignedDepartmentStr': instance.assignedDepartmentStr,
      'wfStatusColor': instance.wfStatusColor,
      'draftStatusObject': instance.draftStatusObject,
      'taskStatusStr': instance.taskStatusStr,
      'taskPriorityStr': instance.taskPriorityStr,
    };

RemoteWFStatusColor _$RemoteWFStatusColorFromJson(Map<String, dynamic> json) =>
    RemoteWFStatusColor(
      color: json['color'] as String? ?? "",
      label: json['label'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteWFStatusColorToJson(
        RemoteWFStatusColor instance) =>
    <String, dynamic>{
      'color': instance.color,
      'label': instance.label,
    };

RemoteProjectName _$RemoteProjectNameFromJson(Map<String, dynamic> json) =>
    RemoteProjectName(
      projectName: json['projectName'] as String? ?? "",
      projectManagerName: json['projectManagerName'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteProjectNameToJson(RemoteProjectName instance) =>
    <String, dynamic>{
      'projectName': instance.projectName,
      'projectManagerName': instance.projectManagerName,
    };
