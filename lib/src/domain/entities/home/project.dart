import 'package:equatable/equatable.dart';
import 'package:mofa/src/domain/entities/home/work_flow_history_list.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';

class ProjectStatusColor extends Equatable {
  final String color;
  final String label;

  const ProjectStatusColor({this.color = '', this.label = ''});

  @override
  List<Object?> get props => [color, label];
}

class Project extends Equatable {
  final String id;
  final String title;
  final String projectCode;
  final String projectName;
  final String projectManagerStr;
  final String projectDisplayName;
  final String projectStatusStr;
  final ProjectStatusColor projectStatusColor;
  final ProjectStatusColor projectPrioColor;
  final ProjectStatusColor validityColor;
  final String projectTypeStr;
  final String managerName;
  final String currentProjectPhaseStr;
  final String currentProjectStageStr;
  final String departmentName;
  final String projectStartDate;
  final String projectEndDate;
  final String projectSponsorName;
  final String projectOwnerName;
  final int percentCompleteValue;
  final int percentPlannedValue;
  final int complianceScoreValue;
  final String projectPriorityName;
  final String projectClassificationStr;
  final bool isHasRisks;
  final bool isHasIssues;
  final bool isBaseline;
  final String validity;
  final String latestUpdateBrief;
  final String latestUpdateDate;
  final String latestUpdateValidityDate;
  final List<Status> kpiValues;
  final int departmentId;
  final int projectWorkflowStatus;
  final List<WorkFlowHistoryList> workflowHistoryList;
  final String assumption;
  final String projectDescriptionWithinScope;
  final String projectOutOfScope;
  final String projectDescription;

  const Project({
    this.title = '',
    this.id = '',
    this.managerName = '',
    this.departmentId = 0,
    this.projectCode = '',
    this.projectStatusStr = '',
    this.projectTypeStr = '',
    this.currentProjectPhaseStr = '',
    this.currentProjectStageStr = '',
    this.departmentName = '',
    this.projectStartDate = '',
    this.projectEndDate = '',
    this.percentCompleteValue = 0,
    this.percentPlannedValue = 0,
    this.projectPriorityName = '',
    this.projectClassificationStr = '',
    this.isHasRisks = false,
    this.isHasIssues = false,
    this.isBaseline = false,
    this.validity = '',
    this.latestUpdateBrief = '',
    this.latestUpdateDate = '',
    this.latestUpdateValidityDate = '',
    this.kpiValues = const [],
    this.projectWorkflowStatus = 0,
    this.workflowHistoryList = const [],
    this.assumption = '',
    this.projectStatusColor = const ProjectStatusColor(),
    this.projectPrioColor = const ProjectStatusColor(),
    this.projectSponsorName = '',
    this.projectOwnerName = '',
    this.projectName = '',
    this.complianceScoreValue = 0,
    this.projectDescriptionWithinScope = '',
    this.projectOutOfScope = '',
    this.projectDescription = '',
    this.projectDisplayName = '',
    this.projectManagerStr = '',
    this.validityColor = const ProjectStatusColor(),
  });

  @override
  List<Object?> get props => [
        title,
        id,
        managerName,
        departmentId,
        projectCode,
        projectStatusStr,
        projectTypeStr,
        currentProjectPhaseStr,
        currentProjectStageStr,
        departmentName,
        projectStartDate,
        projectEndDate,
        percentCompleteValue,
        percentPlannedValue,
        projectPriorityName,
        projectClassificationStr,
        isHasRisks,
        isHasIssues,
        isBaseline,
        validity,
        latestUpdateBrief,
        latestUpdateDate,
        latestUpdateValidityDate,
        kpiValues,
        projectWorkflowStatus,
        workflowHistoryList,
        assumption,
        projectStatusColor,
        projectSponsorName,
        projectOwnerName,
        projectName,
        projectPrioColor,
        complianceScoreValue,
        projectDescriptionWithinScope,
        projectOutOfScope,
        projectDescription,
        projectDisplayName,
        projectManagerStr,
        validityColor,
      ];
}
