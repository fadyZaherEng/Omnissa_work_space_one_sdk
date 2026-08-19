// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_task_update_approval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteTaskUpdateApproval _$RemoteTaskUpdateApprovalFromJson(
        Map<String, dynamic> json) =>
    RemoteTaskUpdateApproval(
      id: json['id'] as String? ?? '',
      projectID: json['projectID'] as String? ?? '',
      projectName: json['projectName'] as String? ?? '',
      taskId: json['taskId'] as String? ?? '',
      taskStartDate: json['taskStartDate'] as String? ?? '',
      taskEndDate: json['taskEndDate'] as String? ?? '',
      taskName: json['taskName'] as String? ?? '',
      taskpercentDone: json['taskpercentDone'] as String? ?? '',
      taskPriorityStr: json['taskPriorityStr'] as String? ?? '',
      taskStatusStr: json['taskStatusStr'] as String? ?? '',
      taskPriority: (json['taskPriority'] as num?)?.toInt() ?? 0,
      requestId: json['requestId'] as String? ?? '',
      assignmentPriorityStr: json['assignmentPriorityStr'] as String? ?? '',
      assignmentStatusStr: json['assignmentStatusStr'] as String? ?? '',
      assignmentpercentDone:
          (json['assignmentpercentDone'] as num?)?.toInt() ?? 0,
      assignmentComments: json['assignmentComments'] as String? ?? '',
      wfStatus: (json['wfStatus'] as num?)?.toInt() ?? 0,
      createdBy: json['createdBy'] as String? ?? '',
      created: json['created'] as String? ?? '',
      creationDate: json['creationDate'] as String? ?? '',
      projectManager: json['projectManager'] as String? ?? '',
    );

Map<String, dynamic> _$RemoteTaskUpdateApprovalToJson(
        RemoteTaskUpdateApproval instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectID': instance.projectID,
      'projectName': instance.projectName,
      'taskId': instance.taskId,
      'taskStartDate': instance.taskStartDate,
      'taskEndDate': instance.taskEndDate,
      'taskName': instance.taskName,
      'taskpercentDone': instance.taskpercentDone,
      'taskPriorityStr': instance.taskPriorityStr,
      'taskStatusStr': instance.taskStatusStr,
      'taskPriority': instance.taskPriority,
      'requestId': instance.requestId,
      'assignmentPriorityStr': instance.assignmentPriorityStr,
      'assignmentStatusStr': instance.assignmentStatusStr,
      'assignmentpercentDone': instance.assignmentpercentDone,
      'assignmentComments': instance.assignmentComments,
      'wfStatus': instance.wfStatus,
      'createdBy': instance.createdBy,
      'created': instance.created,
      'creationDate': instance.creationDate,
      'projectManager': instance.projectManager,
    };
