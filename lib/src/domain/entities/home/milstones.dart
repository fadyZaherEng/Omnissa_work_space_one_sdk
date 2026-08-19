import 'package:equatable/equatable.dart';

class MilstoneProjectStatusColor extends Equatable {
  final String color;
  final String label;

  const MilstoneProjectStatusColor({this.color = '', this.label = ''});

  @override
  List<Object?> get props => [color, label];
}

class Milstones {
  final String id;
  final String name;
  final MilstoneProject project;
  final String startDate;
  final String endDate;
  final int percentDone;
  final String baselineStartDate;
  final String baselineEndDate;
  final int weight;
  final MilstoneProjectStatusColor projectCardStatusStr;

  const Milstones({
    this.id = '',
    this.name = '',
    this.project = const MilstoneProject(),
    this.startDate = '',
    this.endDate = '',
    this.percentDone = 0,
    this.baselineStartDate = '',
    this.baselineEndDate = '',
    this.weight = 0,
    this.projectCardStatusStr = const MilstoneProjectStatusColor(),
  });
}

class MilstoneProject {
  final String id;
  final String projectName;
  final int projectStatus;
  final int projectClassification;
  final int progressKPI;
  final int projectWorkflowStatus;
  final bool requireContract;
  final bool isProgram;
  final int type;
  final int contractAmount;
  final int withholding;
  final int percentPlannedValue;
  final String projectManagerName;
  final bool isImport;
  final bool isHaveWorkflow;
  final bool isBaseline;
  final int percentCompleteValue;
  final int complianceScoreValue;
  final bool isDeleted;
  final bool canEditorDelete;
  final int initiativesPlanningApproachId;
  final int projectPriority;
  final int classification;
  final bool isHasRisks;
  final bool isHasIssues;
  final bool basedOnBusinessCase;
  final int developmentType;
  final bool isHasChangeRequest;
  final bool isCheckedOut;
  final bool requiredProcurement;
  final List<dynamic> importProjectsVMs;
  final List<dynamic> latestUpdateList;
  final List<dynamic> programProjectsList;
  final List<dynamic> workflowHistoryList;
  final List<dynamic> workflowPhasesAndStages;
  final List<dynamic> complianceMasterArchiveList;
  final List<dynamic> constraintsAndLimitationsList;
  final List<dynamic> projectBenefitslist;
  final List<dynamic> vendorInformation;
  final List<dynamic> contractList;

  const MilstoneProject({
    this.id = '',
    this.projectName = '',
    this.projectStatus = 0,
    this.projectClassification = 0,
    this.progressKPI = 0,
    this.projectWorkflowStatus = 0,
    this.requireContract = false,
    this.isProgram = false,
    this.type = 0,
    this.contractAmount = 0,
    this.withholding = 0,
    this.percentPlannedValue = 0,
    this.projectManagerName = '',
    this.isImport = false,
    this.isHaveWorkflow = false,
    this.isBaseline = false,
    this.percentCompleteValue = 0,
    this.complianceScoreValue = 0,
    this.isDeleted = false,
    this.canEditorDelete = false,
    this.initiativesPlanningApproachId = 0,
    this.projectPriority = 0,
    this.classification = 0,
    this.isHasRisks = false,
    this.isHasIssues = false,
    this.basedOnBusinessCase = false,
    this.developmentType = 0,
    this.isHasChangeRequest = false,
    this.isCheckedOut = false,
    this.requiredProcurement = false,
    this.importProjectsVMs = const [],
    this.latestUpdateList = const [],
    this.programProjectsList = const [],
    this.workflowHistoryList = const [],
    this.workflowPhasesAndStages = const [],
    this.complianceMasterArchiveList = const [],
    this.constraintsAndLimitationsList = const [],
    this.projectBenefitslist = const [],
    this.vendorInformation = const [],
    this.contractList = const [],
  });
}
