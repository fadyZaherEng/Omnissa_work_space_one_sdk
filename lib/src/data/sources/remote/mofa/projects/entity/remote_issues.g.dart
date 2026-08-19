// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_issues.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteIssues _$RemoteIssuesFromJson(Map<String, dynamic> json) => RemoteIssues(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      projectManagerStr: json['projectManagerStr'] as String? ?? '',
      ownerStr: json['ownerStr'] as String? ?? '',
      assignedTo: json['assignedTo'] as String? ?? '',
      priorityStr: json['priorityStr'] as String? ?? '',
      dueDate: json['dueDate'] as String? ?? '',
      categoryStr: json['categoryStr'] as String? ?? '',
      statusstr: json['statusstr'] as String? ?? '',
      workflowDisplayStatus: json['workflowDisplayStatus'] == null
          ? const RemoteWorkflowDisplayStatus()
          : RemoteWorkflowDisplayStatus.fromJson(
              json['workflowDisplayStatus'] as Map<String, dynamic>),
      creationDate: json['creationDate'] as String? ?? '',
      workflowStatus: json['workflowStatus'] as String? ?? '',
      workflowCompletionStatus:
          (json['workflowCompletionStatus'] as num?)?.toInt() ?? 0,
      projectName: json['projectName'] as String? ?? '',
      resolvedDate: json['resolvedDate'] as String? ?? '',
      createdByStr: json['createdByStr'] as String? ?? '',
      toBeEscalated: json['toBeEscalated'] as bool? ?? false,
      description: json['description'] as String? ?? '',
      discussion: json['discussion'] as String? ?? '',
      resolution: json['resolution'] as String? ?? '',
      problemFromClient: json['problemFromClient'] as String? ?? '',
      latestUpdates: json['latestUpdates'] as String? ?? '',
      issuePrioColor: json['issuePrioColor'] == null
          ? const RemoteProjectStatusColor()
          : RemoteProjectStatusColor.fromJson(
              json['issuePrioColor'] as Map<String, dynamic>),
      statusColor: json['statusColor'] == null
          ? const RemoteProjectStatusColor()
          : RemoteProjectStatusColor.fromJson(
              json['statusColor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteIssuesToJson(RemoteIssues instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectName': instance.projectName,
      'title': instance.title,
      'categoryStr': instance.categoryStr,
      'priorityStr': instance.priorityStr,
      'statusstr': instance.statusstr,
      'dueDate': instance.dueDate,
      'resolvedDate': instance.resolvedDate,
      'description': instance.description,
      'discussion': instance.discussion,
      'resolution': instance.resolution,
      'problemFromClient': instance.problemFromClient,
      'latestUpdates': instance.latestUpdates,
      'ownerStr': instance.ownerStr,
      'assignedTo': instance.assignedTo,
      'toBeEscalated': instance.toBeEscalated,
      'createdByStr': instance.createdByStr,
      'creationDate': instance.creationDate,
      'workflowStatus': instance.workflowStatus,
      'workflowDisplayStatus': instance.workflowDisplayStatus,
      'workflowCompletionStatus': instance.workflowCompletionStatus,
      'projectManagerStr': instance.projectManagerStr,
      'issuePrioColor': instance.issuePrioColor,
      'statusColor': instance.statusColor,
    };
