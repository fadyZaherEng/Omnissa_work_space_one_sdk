import 'package:equatable/equatable.dart';
import 'package:mofa/src/domain/entities/home/output_attachments.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/home/risks.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';

class Challenges extends Equatable {
  final String id;
  final String projectName;
  final String title;
  final String categoryStr;
  final String priorityStr;
  final String statusStr;
  final String dueDate;
  final String resolvedDate;
  final String description;
  final String discussion;
  final String resolution;
  final String problemFromClient;
  final String latestUpdates;
  final String ownerStr;
  final String assignedTo;
  final bool toBeEscalated;
  final String createdByStr;
  final String creationDate;
  final String workflowStatus;
  final int workflowCompletionStatus;
  final String projectManagerStr;
  final String department;
  final String status;

  // final Color statusColor;
  final Status challengeRisk;
  final String category;
  final String solveDate;
  final String endDate;
  final String suggestSolution;
  final String problemReasons;
  final String problemChallenge;
  final List<OutPutAttachments> attachments;
  final Status severityOfTheChallenge;
  final Status workflowCases;
  final String address;
  final WorkflowDisplayStatus workflowDisplayStatus;
  final ProjectStatusColor issuePrioColor;
  final ProjectStatusColor statusColor;

  const Challenges({
    this.title = '',
    this.id = '',
    this.department = '',
    this.endDate = '',
    this.status = '',
    // this.statusColor = Colors.transparent,
    this.challengeRisk = const Status(),
    this.category = '',
    this.solveDate = '',
    this.description = '',
    this.suggestSolution = '',
    this.problemReasons = '',
    this.attachments = const [],
    this.severityOfTheChallenge = const Status(),
    this.workflowCases = const Status(),
    this.address = '',
    this.problemChallenge = '',
    this.projectManagerStr = '',
    this.ownerStr = '',
    this.assignedTo = '',
    this.priorityStr = '',
    this.dueDate = '',
    this.categoryStr = '',
    this.statusStr = '',
    this.workflowDisplayStatus = const WorkflowDisplayStatus(),
    this.creationDate = '',
    this.projectName = '',
    this.resolvedDate = '',
    this.createdByStr = '',
    this.workflowStatus = '',
    this.workflowCompletionStatus = 0,
    this.problemFromClient = '',
    this.latestUpdates = '',
    this.discussion = '',
    this.resolution = '',
    this.toBeEscalated = false,
    this.issuePrioColor = const ProjectStatusColor(),
    this.statusColor = const ProjectStatusColor(),
  });

  @override
  List<Object?> get props => [
        title,
        id,
        department,
        status,
        statusColor,
        challengeRisk,
        category,
        solveDate,
        endDate,
        description,
        suggestSolution,
        problemReasons,
        attachments,
        severityOfTheChallenge,
        workflowCases,
        address,
        problemChallenge,
        projectManagerStr,
        ownerStr,
        assignedTo,
        priorityStr,
        dueDate,
        categoryStr,
        statusStr,
        workflowDisplayStatus,
        creationDate,
        projectName,
        resolvedDate,
        createdByStr,
        workflowStatus,
        workflowCompletionStatus,
        problemFromClient,
        latestUpdates,
        discussion,
        resolution,
        toBeEscalated,
        issuePrioColor,
        statusColor,
      ];

  //copy with method
  Challenges copyWith({
    String? description,
  }) {
    return Challenges(
      description: description ?? this.description,
    );
  }
}
