import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_kpi_values.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_work_flow_history_list.dart';
import 'package:mofa/src/domain/entities/home/project.dart';

part 'remote_get_all_projects.g.dart';

@JsonSerializable()
class RemoteGetAllProjects {
  final String? id;
  final String? projectName;
  final String? projectDisplayName;
  final String? projectManagerStr;
  final String? projectCode;
  final String? projectStatusStr;
  final RemoteProjectStatusColor projectStatusColor;
  final RemoteProjectStatusColor projectPrioColor;
  final RemoteProjectStatusColor validityColor;
  final String? projectTypeStr;
  final String? currentProjectPhaseStr;
  final String? currentProjectStageStr;
  final String? departmentName;
  final String? projectStartDate;
  final String? projectEndDate;
  final int? percentCompleteValue;
  final int? percentPlannedValue;
  final int? complianceScoreValue;
  final String? projectPriorityName;
  final String? projectClassificationStr;
  final String? projectOwnerName;
  final String? projectSponsorName;
  final bool? isHasRisks;
  final bool? isHasIssues;
  final bool? isBaseline;
  final String? validity;
  final String? latestUpdateBrief;
  final String? latestUpdateDate;
  final String? latestUpdateValidityDate;
  final List<RemoteKpiValues>? kpiValues;
  final int? projectWorkflowStatus;
  final List<RemoteWorkFlowHistoryList>? workflowHistoryList;
  final String? assumption;
  final String? projectDescriptionWithinScope;
  final String? projectOutOfScope;
  final String? projectDescription;

  const RemoteGetAllProjects({
    this.id = "",
    this.projectName = "",
    this.projectCode = "",
    this.projectStatusStr = "",
    this.projectTypeStr = "",
    this.projectManagerStr = "",
    this.currentProjectPhaseStr = "",
    this.currentProjectStageStr = "",
    this.departmentName = "",
    this.projectStartDate = "",
    this.projectEndDate = "",
    this.percentCompleteValue = 0,
    this.percentPlannedValue = 0,
    this.projectPriorityName = "",
    this.projectClassificationStr = "",
    this.isHasRisks = false,
    this.isHasIssues = false,
    this.isBaseline = false,
    this.validity = "",
    this.latestUpdateBrief = "",
    this.latestUpdateDate = "",
    this.latestUpdateValidityDate = "",
    this.kpiValues = const [],
    this.projectWorkflowStatus = 0,
    this.workflowHistoryList = const [],
    this.assumption = "",
    this.projectStatusColor = const RemoteProjectStatusColor(),
    this.projectPrioColor = const RemoteProjectStatusColor(),
    this.projectOwnerName = "",
    this.projectSponsorName = "",
    this.complianceScoreValue = 0,
    this.projectDescriptionWithinScope = "",
    this.projectOutOfScope = "",
    this.projectDescription = "",
    this.projectDisplayName = "",
    this.validityColor = const RemoteProjectStatusColor(),
  });

  factory RemoteGetAllProjects.fromJson(Map<String, dynamic> json) =>
      _$RemoteGetAllProjectsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteGetAllProjectsToJson(this);
}

@JsonSerializable()
class RemoteProjectStatusColor {
  final String? color;
  final String? label;

  const RemoteProjectStatusColor({
    this.color = "",
    this.label = "",
  });

  factory RemoteProjectStatusColor.fromJson(Map<String, dynamic> json) =>
      _$RemoteProjectStatusColorFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteProjectStatusColorToJson(this);
}

extension RemoteProjectStatusColorExt on RemoteProjectStatusColor {
  ProjectStatusColor mapToDomain() => ProjectStatusColor(
        color: color ?? '',
        label: label ?? '',
      );
}

extension RemoteGetAllProjectsExt on RemoteGetAllProjects {
  Project mapToDomain() => Project(
        id: id ?? '',
        title: projectName ?? '',
        projectCode: projectCode ?? '',
        projectStatusStr: projectStatusStr ?? '',
        projectTypeStr: projectTypeStr ?? '',
        currentProjectPhaseStr: currentProjectPhaseStr ?? '',
        currentProjectStageStr: currentProjectStageStr ?? '',
        departmentName: departmentName ?? '',
        projectStartDate: projectStartDate ?? '',
        projectEndDate: projectEndDate ?? '',
        percentCompleteValue: percentCompleteValue ?? 0,
        percentPlannedValue: percentPlannedValue ?? 0,
        projectPriorityName: projectPriorityName ?? '',
        projectClassificationStr: projectClassificationStr ?? '',
        isHasRisks: isHasRisks ?? false,
        isHasIssues: isHasIssues ?? false,
        isBaseline: isBaseline ?? false,
        validity: validity ?? '',
        latestUpdateBrief: latestUpdateBrief ?? '',
        latestUpdateDate: latestUpdateDate ?? '',
        latestUpdateValidityDate: latestUpdateValidityDate ?? '',
        kpiValues: kpiValues?.map((e) => e.mapToDomain()).toList() ?? [],
        managerName: projectManagerStr ?? '',
        validityColor: validityColor.mapToDomain(),
        departmentId: 0,
        projectWorkflowStatus: projectWorkflowStatus ?? 0,
        workflowHistoryList:
            workflowHistoryList?.map((e) => e.mapToDomain()).toList() ?? [],
        assumption: assumption ?? '',
        projectStatusColor: projectStatusColor.mapToDomain(),
        projectOwnerName: projectOwnerName ?? '',
        projectSponsorName: projectSponsorName ?? '',
        projectName: projectName ?? '',
        projectPrioColor: projectPrioColor.mapToDomain(),
        complianceScoreValue: complianceScoreValue ?? 0,
        projectDescriptionWithinScope: projectDescriptionWithinScope ?? '',
        projectOutOfScope: projectOutOfScope ?? '',
        projectDescription: projectDescription ?? '',
        projectDisplayName: projectDisplayName ?? '',
        projectManagerStr: projectManagerStr ?? '',
      );
}

extension ListRemoteGetAllProjectsExt on List<RemoteGetAllProjects> {
  List<Project> mapToDomain() => map((e) => e.mapToDomain()).toList();
}
