// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_get_all_projects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteGetAllProjects _$RemoteGetAllProjectsFromJson(
        Map<String, dynamic> json) =>
    RemoteGetAllProjects(
      id: json['id'] as String? ?? "",
      projectName: json['projectName'] as String? ?? "",
      projectCode: json['projectCode'] as String? ?? "",
      projectStatusStr: json['projectStatusStr'] as String? ?? "",
      projectTypeStr: json['projectTypeStr'] as String? ?? "",
      projectManagerStr: json['projectManagerStr'] as String? ?? "",
      currentProjectPhaseStr: json['currentProjectPhaseStr'] as String? ?? "",
      currentProjectStageStr: json['currentProjectStageStr'] as String? ?? "",
      departmentName: json['departmentName'] as String? ?? "",
      projectStartDate: json['projectStartDate'] as String? ?? "",
      projectEndDate: json['projectEndDate'] as String? ?? "",
      percentCompleteValue:
          (json['percentCompleteValue'] as num?)?.toInt() ?? 0,
      percentPlannedValue: (json['percentPlannedValue'] as num?)?.toInt() ?? 0,
      projectPriorityName: json['projectPriorityName'] as String? ?? "",
      projectClassificationStr:
          json['projectClassificationStr'] as String? ?? "",
      isHasRisks: json['isHasRisks'] as bool? ?? false,
      isHasIssues: json['isHasIssues'] as bool? ?? false,
      isBaseline: json['isBaseline'] as bool? ?? false,
      validity: json['validity'] as String? ?? "",
      latestUpdateBrief: json['latestUpdateBrief'] as String? ?? "",
      latestUpdateDate: json['latestUpdateDate'] as String? ?? "",
      latestUpdateValidityDate:
          json['latestUpdateValidityDate'] as String? ?? "",
      kpiValues: (json['kpiValues'] as List<dynamic>?)
              ?.map((e) => RemoteKpiValues.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      projectWorkflowStatus:
          (json['projectWorkflowStatus'] as num?)?.toInt() ?? 0,
      workflowHistoryList: (json['workflowHistoryList'] as List<dynamic>?)
              ?.map((e) =>
                  RemoteWorkFlowHistoryList.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      assumption: json['assumption'] as String? ?? "",
      projectStatusColor: json['projectStatusColor'] == null
          ? const RemoteProjectStatusColor()
          : RemoteProjectStatusColor.fromJson(
              json['projectStatusColor'] as Map<String, dynamic>),
      projectPrioColor: json['projectPrioColor'] == null
          ? const RemoteProjectStatusColor()
          : RemoteProjectStatusColor.fromJson(
              json['projectPrioColor'] as Map<String, dynamic>),
      projectOwnerName: json['projectOwnerName'] as String? ?? "",
      projectSponsorName: json['projectSponsorName'] as String? ?? "",
      complianceScoreValue:
          (json['complianceScoreValue'] as num?)?.toInt() ?? 0,
      projectDescriptionWithinScope:
          json['projectDescriptionWithinScope'] as String? ?? "",
      projectOutOfScope: json['projectOutOfScope'] as String? ?? "",
      projectDescription: json['projectDescription'] as String? ?? "",
      projectDisplayName: json['projectDisplayName'] as String? ?? "",
      validityColor: json['validityColor'] == null
          ? const RemoteProjectStatusColor()
          : RemoteProjectStatusColor.fromJson(
              json['validityColor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteGetAllProjectsToJson(
        RemoteGetAllProjects instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectName': instance.projectName,
      'projectDisplayName': instance.projectDisplayName,
      'projectManagerStr': instance.projectManagerStr,
      'projectCode': instance.projectCode,
      'projectStatusStr': instance.projectStatusStr,
      'projectStatusColor': instance.projectStatusColor,
      'projectPrioColor': instance.projectPrioColor,
      'validityColor': instance.validityColor,
      'projectTypeStr': instance.projectTypeStr,
      'currentProjectPhaseStr': instance.currentProjectPhaseStr,
      'currentProjectStageStr': instance.currentProjectStageStr,
      'departmentName': instance.departmentName,
      'projectStartDate': instance.projectStartDate,
      'projectEndDate': instance.projectEndDate,
      'percentCompleteValue': instance.percentCompleteValue,
      'percentPlannedValue': instance.percentPlannedValue,
      'complianceScoreValue': instance.complianceScoreValue,
      'projectPriorityName': instance.projectPriorityName,
      'projectClassificationStr': instance.projectClassificationStr,
      'projectOwnerName': instance.projectOwnerName,
      'projectSponsorName': instance.projectSponsorName,
      'isHasRisks': instance.isHasRisks,
      'isHasIssues': instance.isHasIssues,
      'isBaseline': instance.isBaseline,
      'validity': instance.validity,
      'latestUpdateBrief': instance.latestUpdateBrief,
      'latestUpdateDate': instance.latestUpdateDate,
      'latestUpdateValidityDate': instance.latestUpdateValidityDate,
      'kpiValues': instance.kpiValues,
      'projectWorkflowStatus': instance.projectWorkflowStatus,
      'workflowHistoryList': instance.workflowHistoryList,
      'assumption': instance.assumption,
      'projectDescriptionWithinScope': instance.projectDescriptionWithinScope,
      'projectOutOfScope': instance.projectOutOfScope,
      'projectDescription': instance.projectDescription,
    };

RemoteProjectStatusColor _$RemoteProjectStatusColorFromJson(
        Map<String, dynamic> json) =>
    RemoteProjectStatusColor(
      color: json['color'] as String? ?? "",
      label: json['label'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteProjectStatusColorToJson(
        RemoteProjectStatusColor instance) =>
    <String, dynamic>{
      'color': instance.color,
      'label': instance.label,
    };
