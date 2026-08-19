import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/domain/entities/home/milstones.dart';

part 'remote_milstones.g.dart';

@JsonSerializable()
class RemoteMilstoneStatus {
  final String? color;
  final String? label;

  const RemoteMilstoneStatus({
    this.color = "",
    this.label = "",
  });

  factory RemoteMilstoneStatus.fromJson(Map<String, dynamic> json) =>
      _$RemoteMilstoneStatusFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteMilstoneStatusToJson(this);
}

extension RemoteMilstoneStatusExt on RemoteMilstoneStatus {
  MilstoneProjectStatusColor mapToDomain() => MilstoneProjectStatusColor(
        color: color ?? '',
        label: label ?? '',
      );
}

@JsonSerializable()
class RemoteMilstones {
  final String? id;
  final String? name;
  final RemoteProject? project;
  final String? startDate;
  final String? endDate;
  final int? percentDone;
  final String? baselineStartDate;
  final String? baselineEndDate;
  final int? weight;
  final RemoteMilstoneStatus? projectCardStatusStr;

  const RemoteMilstones({
    this.id,
    this.name,
    this.project,
    this.startDate,
    this.endDate,
    this.percentDone,
    this.baselineStartDate,
    this.baselineEndDate,
    this.weight,
    this.projectCardStatusStr = const RemoteMilstoneStatus(),
  });

  factory RemoteMilstones.fromJson(Map<String, dynamic> json) =>
      _$RemoteMilstonesFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteMilstonesToJson(this);
}

extension RemoteMilstonesListExtension on List<RemoteMilstones> {
  List<Milstones> toDomain() {
    return map((remoteMilstones) => remoteMilstones.toDomain()).toList();
  }
}

extension RemoteMilstonesExtension on RemoteMilstones? {
  Milstones toDomain() {
    return Milstones(
      id: this?.id ?? '',
      name: this?.name ?? '',
      project: this?.project?.toDomain() ?? const MilstoneProject(),
      startDate: this?.startDate ?? '',
      endDate: this?.endDate ?? '',
      percentDone: this?.percentDone ?? 0,
      baselineStartDate: this?.baselineStartDate ?? '',
      baselineEndDate: this?.baselineEndDate ?? '',
      weight: this?.weight ?? 0,
      projectCardStatusStr: this?.projectCardStatusStr?.mapToDomain() ??
          const MilstoneProjectStatusColor(),
    );
  }
}

@JsonSerializable()
class RemoteProject {
  final String? id;
  final String? projectName;
  final int? projectStatus;
  final int? projectClassification;
  final int? progressKPI;
  final int? projectWorkflowStatus;
  final bool? requireContract;
  final bool? isProgram;
  final int? type;
  final int? contractAmount;
  final int? withholding;
  final int? percentPlannedValue;
  final String? projectManagerName;
  final bool? isImport;
  final bool? isHaveWorkflow;
  final bool? isBaseline;
  final int? percentCompleteValue;
  final int? complianceScoreValue;
  final bool? isDeleted;
  final bool? canEditorDelete;
  final int? initiativesPlanningApproachId;
  final int? projectPriority;
  final int? classification;
  final bool? isHasRisks;
  final bool? isHasIssues;
  final bool? basedOnBusinessCase;
  final int? developmentType;
  final bool? isHasChangeRequest;
  final bool? isCheckedOut;
  final bool? requiredProcurement;
  final List<dynamic>? importProjectsVMs;
  final List<dynamic>? latestUpdateList;
  final List<dynamic>? programProjectsList;
  final List<dynamic>? workflowHistoryList;
  final List<dynamic>? workflowPhasesAndStages;
  final List<dynamic>? complianceMasterArchiveList;
  final List<dynamic>? constraintsAndLimitationsList;
  @JsonKey(name: 'project_BenefitsList')
  final List<dynamic>? projectBenefitslist;
  final List<dynamic>? vendorInformation;
  final List<dynamic>? contractList;

  const RemoteProject({
    this.id,
    this.projectName,
    this.projectStatus,
    this.projectClassification,
    this.progressKPI,
    this.projectWorkflowStatus,
    this.requireContract,
    this.isProgram,
    this.type,
    this.contractAmount,
    this.withholding,
    this.percentPlannedValue,
    this.projectManagerName,
    this.isImport,
    this.isHaveWorkflow,
    this.isBaseline,
    this.percentCompleteValue,
    this.complianceScoreValue,
    this.isDeleted,
    this.canEditorDelete,
    this.initiativesPlanningApproachId,
    this.projectPriority,
    this.classification,
    this.isHasRisks,
    this.isHasIssues,
    this.basedOnBusinessCase,
    this.developmentType,
    this.isHasChangeRequest,
    this.isCheckedOut,
    this.requiredProcurement,
    this.importProjectsVMs,
    this.latestUpdateList,
    this.programProjectsList,
    this.workflowHistoryList,
    this.workflowPhasesAndStages,
    this.complianceMasterArchiveList,
    this.constraintsAndLimitationsList,
    this.projectBenefitslist,
    this.vendorInformation,
    this.contractList,
  });

  factory RemoteProject.fromJson(Map<String, dynamic> json) =>
      _$RemoteProjectFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteProjectToJson(this);
}

extension RemoteProjectExtension on RemoteProject {
  MilstoneProject toDomain() {
    return MilstoneProject(
      id: id ?? '',
      projectName: projectName ?? '',
      projectStatus: projectStatus ?? 0,
      projectClassification: projectClassification ?? 0,
      progressKPI: progressKPI ?? 0,
      projectWorkflowStatus: projectWorkflowStatus ?? 0,
      requireContract: requireContract ?? false,
      isProgram: isProgram ?? false,
      type: type ?? 0,
      contractAmount: contractAmount ?? 0,
      withholding: withholding ?? 0,
      percentPlannedValue: percentPlannedValue ?? 0,
      projectManagerName: projectManagerName ?? '',
      isImport: isImport ?? false,
      isHaveWorkflow: isHaveWorkflow ?? false,
      isBaseline: isBaseline ?? false,
      percentCompleteValue: percentCompleteValue ?? 0,
      complianceScoreValue: complianceScoreValue ?? 0,
      isDeleted: isDeleted ?? false,
      canEditorDelete: canEditorDelete ?? false,
      initiativesPlanningApproachId: initiativesPlanningApproachId ?? 0,
      projectPriority: projectPriority ?? 0,
      classification: classification ?? 0,
      isHasRisks: isHasRisks ?? false,
      isHasIssues: isHasIssues ?? false,
      basedOnBusinessCase: basedOnBusinessCase ?? false,
      developmentType: developmentType ?? 0,
      isHasChangeRequest: isHasChangeRequest ?? false,
      isCheckedOut: isCheckedOut ?? false,
      requiredProcurement: requiredProcurement ?? false,
      importProjectsVMs: importProjectsVMs ?? const [],
      latestUpdateList: latestUpdateList ?? const [],
      programProjectsList: programProjectsList ?? const [],
      workflowHistoryList: workflowHistoryList ?? const [],
      workflowPhasesAndStages: workflowPhasesAndStages ?? const [],
      complianceMasterArchiveList: complianceMasterArchiveList ?? const [],
      constraintsAndLimitationsList: constraintsAndLimitationsList ?? const [],
      projectBenefitslist: projectBenefitslist ?? const [],
      vendorInformation: vendorInformation ?? const [],
      contractList: contractList ?? const [],
    );
  }
}
