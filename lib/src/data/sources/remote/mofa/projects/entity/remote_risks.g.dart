// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_risks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteRisks _$RemoteRisksFromJson(Map<String, dynamic> json) => RemoteRisks(
      id: json['id'] as String? ?? "",
      title: json['title'] as String? ?? "",
      impact: (json['impact'] as num?)?.toInt() ?? 0,
      projectManagerStr: json['projectManagerStr'] as String? ?? "",
      ownerStr: json['ownerStr'] as String? ?? "",
      assignedTo: json['assignedTo'] as String? ?? "",
      statusstr: json['statusstr'] as String? ?? "",
      categoryStr: json['categoryStr'] as String? ?? "",
      riskProbability: (json['riskProbability'] as num?)?.toInt() ?? 0,
      exposure: (json['exposure'] as num?)?.toInt() ?? 0,
      workflowDisplayStatus: json['workflowDisplayStatus'] == null
          ? const RemoteWorkflowDisplayStatus()
          : RemoteWorkflowDisplayStatus.fromJson(
              json['workflowDisplayStatus'] as Map<String, dynamic>),
      creationDate: json['creationDate'] as String? ?? "",
      workflowStatus: json['workflowStatus'] as String? ?? "",
      workflowCompletionStatus:
          (json['workflowCompletionStatus'] as num?)?.toInt() ?? 0,
      projectName: json['projectName'] as String? ?? "",
      dueDate: json['dueDate'] as String? ?? "",
      createdByStr: json['createdByStr'] as String? ?? "",
      toBeEscalated: json['toBeEscalated'] as bool? ?? false,
      resolvedDate: json['resolvedDate'] as String? ?? "",
      problemFromClient: json['problemFromClient'] as String? ?? "",
      description: json['description'] as String? ?? "",
      mitigationPlan: json['mitigationPlan'] as String? ?? "",
      contingencyPlan: json['contingencyPlan'] as String? ?? "",
      latestUpdate: json['latestUpdate'] as String? ?? "",
      resolution: json['resolution'] == null
          ? const RemoteProjectStatusColor()
          : RemoteProjectStatusColor.fromJson(
              json['resolution'] as Map<String, dynamic>),
      discussion: json['discussion'] == null
          ? const RemoteProjectStatusColor()
          : RemoteProjectStatusColor.fromJson(
              json['discussion'] as Map<String, dynamic>),
      severityColor: json['severityColor'] == null
          ? const RemoteProjectStatusColor()
          : RemoteProjectStatusColor.fromJson(
              json['severityColor'] as Map<String, dynamic>),
      statusColor: json['statusColor'] == null
          ? const RemoteProjectStatusColor()
          : RemoteProjectStatusColor.fromJson(
              json['statusColor'] as Map<String, dynamic>),
      riskProbabilityColor: json['riskProbabilityColor'] == null
          ? const RemoteProjectStatusColor()
          : RemoteProjectStatusColor.fromJson(
              json['riskProbabilityColor'] as Map<String, dynamic>),
      impactColor: json['impactColor'] == null
          ? const RemoteProjectStatusColor()
          : RemoteProjectStatusColor.fromJson(
              json['impactColor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteRisksToJson(RemoteRisks instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectName': instance.projectName,
      'projectManagerStr': instance.projectManagerStr,
      'ownerStr': instance.ownerStr,
      'title': instance.title,
      'categoryStr': instance.categoryStr,
      'riskProbability': instance.riskProbability,
      'assignedTo': instance.assignedTo,
      'statusstr': instance.statusstr,
      'impact': instance.impact,
      'exposure': instance.exposure,
      'problemFromClient': instance.problemFromClient,
      'description': instance.description,
      'mitigationPlan': instance.mitigationPlan,
      'contingencyPlan': instance.contingencyPlan,
      'toBeEscalated': instance.toBeEscalated,
      'dueDate': instance.dueDate,
      'resolvedDate': instance.resolvedDate,
      'latestUpdate': instance.latestUpdate,
      'creationDate': instance.creationDate,
      'createdByStr': instance.createdByStr,
      'workflowStatus': instance.workflowStatus,
      'workflowCompletionStatus': instance.workflowCompletionStatus,
      'workflowDisplayStatus': instance.workflowDisplayStatus,
      'resolution': instance.resolution,
      'discussion': instance.discussion,
      'severityColor': instance.severityColor,
      'statusColor': instance.statusColor,
      'riskProbabilityColor': instance.riskProbabilityColor,
      'impactColor': instance.impactColor,
    };

RemoteWorkflowDisplayStatus _$RemoteWorkflowDisplayStatusFromJson(
        Map<String, dynamic> json) =>
    RemoteWorkflowDisplayStatus(
      name: json['name'] as String? ?? "",
      color: json['color'] as String? ?? "",
      backgroundColor: json['backgroundColor'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteWorkflowDisplayStatusToJson(
        RemoteWorkflowDisplayStatus instance) =>
    <String, dynamic>{
      'name': instance.name,
      'color': instance.color,
      'backgroundColor': instance.backgroundColor,
    };
