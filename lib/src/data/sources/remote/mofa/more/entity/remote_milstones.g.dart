// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_milstones.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteMilstoneStatus _$RemoteMilstoneStatusFromJson(
        Map<String, dynamic> json) =>
    RemoteMilstoneStatus(
      color: json['color'] as String? ?? "",
      label: json['label'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteMilstoneStatusToJson(
        RemoteMilstoneStatus instance) =>
    <String, dynamic>{
      'color': instance.color,
      'label': instance.label,
    };

RemoteMilstones _$RemoteMilstonesFromJson(Map<String, dynamic> json) =>
    RemoteMilstones(
      id: json['id'] as String?,
      name: json['name'] as String?,
      project: json['project'] == null
          ? null
          : RemoteProject.fromJson(json['project'] as Map<String, dynamic>),
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      percentDone: (json['percentDone'] as num?)?.toInt(),
      baselineStartDate: json['baselineStartDate'] as String?,
      baselineEndDate: json['baselineEndDate'] as String?,
      weight: (json['weight'] as num?)?.toInt(),
      projectCardStatusStr: json['projectCardStatusStr'] == null
          ? const RemoteMilstoneStatus()
          : RemoteMilstoneStatus.fromJson(
              json['projectCardStatusStr'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteMilstonesToJson(RemoteMilstones instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'project': instance.project,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'percentDone': instance.percentDone,
      'baselineStartDate': instance.baselineStartDate,
      'baselineEndDate': instance.baselineEndDate,
      'weight': instance.weight,
      'projectCardStatusStr': instance.projectCardStatusStr,
    };

RemoteProject _$RemoteProjectFromJson(Map<String, dynamic> json) =>
    RemoteProject(
      id: json['id'] as String?,
      projectName: json['projectName'] as String?,
      projectStatus: (json['projectStatus'] as num?)?.toInt(),
      projectClassification: (json['projectClassification'] as num?)?.toInt(),
      progressKPI: (json['progressKPI'] as num?)?.toInt(),
      projectWorkflowStatus: (json['projectWorkflowStatus'] as num?)?.toInt(),
      requireContract: json['requireContract'] as bool?,
      isProgram: json['isProgram'] as bool?,
      type: (json['type'] as num?)?.toInt(),
      contractAmount: (json['contractAmount'] as num?)?.toInt(),
      withholding: (json['withholding'] as num?)?.toInt(),
      percentPlannedValue: (json['percentPlannedValue'] as num?)?.toInt(),
      projectManagerName: json['projectManagerName'] as String?,
      isImport: json['isImport'] as bool?,
      isHaveWorkflow: json['isHaveWorkflow'] as bool?,
      isBaseline: json['isBaseline'] as bool?,
      percentCompleteValue: (json['percentCompleteValue'] as num?)?.toInt(),
      complianceScoreValue: (json['complianceScoreValue'] as num?)?.toInt(),
      isDeleted: json['isDeleted'] as bool?,
      canEditorDelete: json['canEditorDelete'] as bool?,
      initiativesPlanningApproachId:
          (json['initiativesPlanningApproachId'] as num?)?.toInt(),
      projectPriority: (json['projectPriority'] as num?)?.toInt(),
      classification: (json['classification'] as num?)?.toInt(),
      isHasRisks: json['isHasRisks'] as bool?,
      isHasIssues: json['isHasIssues'] as bool?,
      basedOnBusinessCase: json['basedOnBusinessCase'] as bool?,
      developmentType: (json['developmentType'] as num?)?.toInt(),
      isHasChangeRequest: json['isHasChangeRequest'] as bool?,
      isCheckedOut: json['isCheckedOut'] as bool?,
      requiredProcurement: json['requiredProcurement'] as bool?,
      importProjectsVMs: json['importProjectsVMs'] as List<dynamic>?,
      latestUpdateList: json['latestUpdateList'] as List<dynamic>?,
      programProjectsList: json['programProjectsList'] as List<dynamic>?,
      workflowHistoryList: json['workflowHistoryList'] as List<dynamic>?,
      workflowPhasesAndStages:
          json['workflowPhasesAndStages'] as List<dynamic>?,
      complianceMasterArchiveList:
          json['complianceMasterArchiveList'] as List<dynamic>?,
      constraintsAndLimitationsList:
          json['constraintsAndLimitationsList'] as List<dynamic>?,
      projectBenefitslist: json['project_BenefitsList'] as List<dynamic>?,
      vendorInformation: json['vendorInformation'] as List<dynamic>?,
      contractList: json['contractList'] as List<dynamic>?,
    );

Map<String, dynamic> _$RemoteProjectToJson(RemoteProject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectName': instance.projectName,
      'projectStatus': instance.projectStatus,
      'projectClassification': instance.projectClassification,
      'progressKPI': instance.progressKPI,
      'projectWorkflowStatus': instance.projectWorkflowStatus,
      'requireContract': instance.requireContract,
      'isProgram': instance.isProgram,
      'type': instance.type,
      'contractAmount': instance.contractAmount,
      'withholding': instance.withholding,
      'percentPlannedValue': instance.percentPlannedValue,
      'projectManagerName': instance.projectManagerName,
      'isImport': instance.isImport,
      'isHaveWorkflow': instance.isHaveWorkflow,
      'isBaseline': instance.isBaseline,
      'percentCompleteValue': instance.percentCompleteValue,
      'complianceScoreValue': instance.complianceScoreValue,
      'isDeleted': instance.isDeleted,
      'canEditorDelete': instance.canEditorDelete,
      'initiativesPlanningApproachId': instance.initiativesPlanningApproachId,
      'projectPriority': instance.projectPriority,
      'classification': instance.classification,
      'isHasRisks': instance.isHasRisks,
      'isHasIssues': instance.isHasIssues,
      'basedOnBusinessCase': instance.basedOnBusinessCase,
      'developmentType': instance.developmentType,
      'isHasChangeRequest': instance.isHasChangeRequest,
      'isCheckedOut': instance.isCheckedOut,
      'requiredProcurement': instance.requiredProcurement,
      'importProjectsVMs': instance.importProjectsVMs,
      'latestUpdateList': instance.latestUpdateList,
      'programProjectsList': instance.programProjectsList,
      'workflowHistoryList': instance.workflowHistoryList,
      'workflowPhasesAndStages': instance.workflowPhasesAndStages,
      'complianceMasterArchiveList': instance.complianceMasterArchiveList,
      'constraintsAndLimitationsList': instance.constraintsAndLimitationsList,
      'project_BenefitsList': instance.projectBenefitslist,
      'vendorInformation': instance.vendorInformation,
      'contractList': instance.contractList,
    };
