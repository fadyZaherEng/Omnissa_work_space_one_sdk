import 'package:equatable/equatable.dart';
import 'package:mofa/src/domain/entities/home/output_attachments.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';

class Risks extends Equatable {
  final String id;
  final String projectName;
  final String projectManagerStr;
  final String ownerStr;
  final String title;
  final String categoryStr;
  final int riskProbability;
  final String assignedTo;
  final int impact;
  final int exposure;
  final String problemFromClient;
  final String description;
  final String mitigationPlan;
  final String contingencyPlan;
  final bool toBeEscalated;
  final String dueDate;
  final String resolvedDate;
  final String latestUpdate;
  final String creationDate;
  final String createdByStr;
  final String workflowStatus;
  final int workflowCompletionStatus;
  final String specificDate;
  final String statusStr;
  final String address;

  // final Color statusColor;
  final Status riskStatus;
  final Status riskEffect;
  final Status riskStrong;
  final Status severityOfTheChallenge;
  final Status workflowCases;
  final List<OutPutAttachments> attachments;
  final WorkflowDisplayStatus workflowDisplayStatus;
  final ProjectStatusColor resolution;
  final ProjectStatusColor discussion;
  final ProjectStatusColor severityColor;
  final ProjectStatusColor statusColor;
  final ProjectStatusColor riskProbabilityColor;
  final ProjectStatusColor impactColor;

  const Risks({
    this.title = '',
    this.id = '',
    this.specificDate = '',
    // this.statusColor = Colors.white,
    this.riskStatus = const Status(),
    this.riskEffect = const Status(),
    this.riskStrong = const Status(),
    this.description = '',
    this.attachments = const [],
    this.severityOfTheChallenge = const Status(),
    this.workflowCases = const Status(),
    this.address = '',
    this.projectManagerStr = '',
    this.ownerStr = '',
    this.categoryStr = '',
    this.statusStr = '',
    this.impact = 0,
    this.assignedTo = "",
    this.riskProbability = 0,
    this.exposure = 0,
    this.workflowDisplayStatus = const WorkflowDisplayStatus(),
    this.creationDate = "",
    this.workflowStatus = "",
    this.workflowCompletionStatus = 0,
    this.projectName = "",
    this.dueDate = "",
    this.createdByStr = "",
    this.problemFromClient = "",
    this.mitigationPlan = "",
    this.contingencyPlan = "",
    this.toBeEscalated = false,
    this.resolvedDate = "",
    this.latestUpdate = "",
    this.resolution = const ProjectStatusColor(),
    this.discussion = const ProjectStatusColor(),
    this.severityColor = const ProjectStatusColor(),
    this.statusColor = const ProjectStatusColor(),
    this.riskProbabilityColor = const ProjectStatusColor(),
    this.impactColor = const ProjectStatusColor(),
  });

  @override
  List<Object?> get props => [
        title,
        id,
        specificDate,
        statusColor,
        riskStatus,
        riskEffect,
        riskStrong,
        description,
        attachments,
        severityOfTheChallenge,
        workflowCases,
        address,
        projectManagerStr,
        ownerStr,
        categoryStr,
        statusStr,
        impact,
        assignedTo,
        riskProbability,
        exposure,
        workflowDisplayStatus,
        creationDate,
        workflowStatus,
        workflowCompletionStatus,
        projectName,
        dueDate,
        createdByStr,
        problemFromClient,
        mitigationPlan,
        contingencyPlan,
        toBeEscalated,
        resolvedDate,
        latestUpdate,
        resolution,
        discussion,
        severityColor,
        statusColor,
        riskProbabilityColor,
        impactColor,
      ];
}

class WorkflowDisplayStatus {
  final String name;
  final String color;
  final String backgroundColor;

  const WorkflowDisplayStatus({
    this.name = "",
    this.color = "",
    this.backgroundColor = "",
  });

  factory WorkflowDisplayStatus.fromJson(Map<String, dynamic> json) {
    return WorkflowDisplayStatus(
      name: json['name'] as String,
      color: json['color'] as String,
      backgroundColor: json['backgroundColor'] as String,
    );
  }
}
