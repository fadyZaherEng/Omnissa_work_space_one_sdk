import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_get_all_projects.dart';
import 'package:mofa/src/domain/entities/home/risks.dart';

part 'remote_risks.g.dart';

@JsonSerializable()
class RemoteRisks {
  final String? id;
  final String? projectName;
  final String? projectManagerStr;
  final String? ownerStr;
  final String? title;
  final String? categoryStr;
  final int? riskProbability;
  final String? assignedTo;
  final String? statusstr;
  final int? impact;
  final int? exposure;
  final String? problemFromClient;
  final String? description;
  final String? mitigationPlan;
  final String? contingencyPlan;
  final bool? toBeEscalated;
  final String? dueDate;
  final String? resolvedDate;
  final String? latestUpdate;
  final String? creationDate;
  final String? createdByStr;
  final String? workflowStatus;
  final int? workflowCompletionStatus;
  final RemoteWorkflowDisplayStatus? workflowDisplayStatus;
  final RemoteProjectStatusColor resolution;
  final RemoteProjectStatusColor discussion;
  final RemoteProjectStatusColor severityColor;
  final RemoteProjectStatusColor statusColor;
  final RemoteProjectStatusColor riskProbabilityColor;
  final RemoteProjectStatusColor impactColor;

  const RemoteRisks({
    this.id = "",
    this.title = "",
    this.impact = 0,
    this.projectManagerStr = "",
    this.ownerStr = "",
    this.assignedTo = "",
    this.statusstr = "",
    this.categoryStr = "",
    this.riskProbability = 0,
    this.exposure = 0,
    this.workflowDisplayStatus = const RemoteWorkflowDisplayStatus(),
    this.creationDate = "",
    this.workflowStatus = "",
    this.workflowCompletionStatus = 0,
    this.projectName = "",
    this.dueDate = "",
    this.createdByStr = "",
    this.toBeEscalated = false,
    this.resolvedDate = "",
    this.problemFromClient = "",
    this.description = "",
    this.mitigationPlan = "",
    this.contingencyPlan = "",
    this.latestUpdate = "",
    this.resolution = const RemoteProjectStatusColor(),
    this.discussion = const RemoteProjectStatusColor(),
    this.severityColor = const RemoteProjectStatusColor(),
    this.statusColor = const RemoteProjectStatusColor(),
    this.riskProbabilityColor = const RemoteProjectStatusColor(),
    this.impactColor = const RemoteProjectStatusColor(),
  });

  factory RemoteRisks.fromJson(Map<String, dynamic> json) =>
      _$RemoteRisksFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteRisksToJson(this);
}

@JsonSerializable()
class RemoteWorkflowDisplayStatus {
  final String? name;
  final String? color;
  final String? backgroundColor;

  const RemoteWorkflowDisplayStatus({
    this.name = "",
    this.color = "",
    this.backgroundColor = "",
  });

  factory RemoteWorkflowDisplayStatus.fromJson(Map<String, dynamic> json) =>
      _$RemoteWorkflowDisplayStatusFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteWorkflowDisplayStatusToJson(this);
}

extension RemoteWorkflowDisplayStatusExtension on RemoteWorkflowDisplayStatus {
  WorkflowDisplayStatus mapToDomain() => WorkflowDisplayStatus(
        name: name ?? '',
        color: color ?? '',
        backgroundColor: backgroundColor ?? '',
      );
}

extension RemoteRisksExtension on RemoteRisks {
  Risks mapToDomain() {
    return Risks(
      id: id ?? '',
      title: title ?? '',
      impact: impact ?? 0,
      projectManagerStr: projectManagerStr ?? '',
      ownerStr: ownerStr ?? '',
      assignedTo: assignedTo ?? '',
      statusStr: statusstr ?? '',
      categoryStr: categoryStr ?? '',
      riskProbability: riskProbability ?? 0,
      exposure: exposure ?? 0,
      workflowDisplayStatus:
          workflowDisplayStatus?.mapToDomain() ?? const WorkflowDisplayStatus(),
      creationDate: creationDate ?? '',
      workflowStatus: workflowStatus ?? '',
      workflowCompletionStatus: workflowCompletionStatus ?? 0,
      projectName: projectName ?? '',
      dueDate: dueDate ?? '',
      createdByStr: createdByStr ?? '',
      toBeEscalated: toBeEscalated ?? false,
      resolvedDate: resolvedDate ?? '',
      problemFromClient: problemFromClient ?? '',
      description: description ?? '',
      mitigationPlan: mitigationPlan ?? '',
      contingencyPlan: contingencyPlan ?? '',
      latestUpdate: latestUpdate ?? '',
      resolution: resolution.mapToDomain(),
      discussion: discussion.mapToDomain(),
      severityColor: severityColor.mapToDomain(),
      statusColor: statusColor.mapToDomain(),
      riskProbabilityColor: riskProbabilityColor.mapToDomain(),
      impactColor: impactColor.mapToDomain(),
    );
  }
}

extension ListRemoteRisksExtension on List<RemoteRisks> {
  List<Risks> mapToDomain() => map((e) => e.mapToDomain()).toList();
}
