import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_get_all_projects.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_risks.dart';
import 'package:mofa/src/domain/entities/home/challenges.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/home/risks.dart';

part 'remote_issues.g.dart';

@JsonSerializable()
class RemoteIssues {
  final String? id;
  final String? projectName;
  final String? title;
  final String? categoryStr;
  final String? priorityStr;
  final String? statusstr;
  final String? dueDate;
  final String? resolvedDate;
  final String? description;
  final String? discussion;
  final String? resolution;
  final String? problemFromClient;
  final String? latestUpdates;
  final String? ownerStr;
  final String? assignedTo;
  final bool? toBeEscalated;
  final String? createdByStr;
  final String? creationDate;
  final String? workflowStatus;
  final RemoteWorkflowDisplayStatus? workflowDisplayStatus;
  final int? workflowCompletionStatus;
  final String? projectManagerStr;
  final RemoteProjectStatusColor? issuePrioColor;
  final RemoteProjectStatusColor? statusColor;

  const RemoteIssues({
    this.id = '',
    this.title = '',
    this.projectManagerStr = '',
    this.ownerStr = '',
    this.assignedTo = '',
    this.priorityStr = '',
    this.dueDate = '',
    this.categoryStr = '',
    this.statusstr = '',
    this.workflowDisplayStatus = const RemoteWorkflowDisplayStatus(),
    this.creationDate = '',
    this.workflowStatus = '',
    this.workflowCompletionStatus = 0,
    this.projectName = '',
    this.resolvedDate = '',
    this.createdByStr = '',
    this.toBeEscalated = false,
    this.description = '',
    this.discussion = '',
    this.resolution = '',
    this.problemFromClient = '',
    this.latestUpdates = '',
    this.issuePrioColor = const RemoteProjectStatusColor(),
    this.statusColor = const RemoteProjectStatusColor(),
  });

  factory RemoteIssues.fromJson(Map<String, dynamic> json) =>
      _$RemoteIssuesFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteIssuesToJson(this);
}

extension RemoteIssuesExtension on RemoteIssues {
  Challenges mapToDomain() {
    return Challenges(
      id: id ?? '',
      title: title ?? '',
      projectManagerStr: projectManagerStr ?? '',
      ownerStr: ownerStr ?? '',
      assignedTo: assignedTo ?? '',
      priorityStr: priorityStr ?? '',
      dueDate: dueDate ?? '',
      categoryStr: categoryStr ?? '',
      statusStr: statusstr ?? '',
      workflowDisplayStatus:
          workflowDisplayStatus?.mapToDomain() ?? const WorkflowDisplayStatus(),
      creationDate: creationDate ?? '',
      workflowStatus: workflowStatus ?? '',
      workflowCompletionStatus: workflowCompletionStatus ?? 0,
      projectName: projectName ?? '',
      resolvedDate: resolvedDate ?? '',
      createdByStr: createdByStr ?? '',
      toBeEscalated: toBeEscalated ?? false,
      description: description ?? '',
      discussion: discussion ?? '',
      resolution: resolution ?? '',
      problemFromClient: problemFromClient ?? '',
      latestUpdates: latestUpdates ?? '',
      issuePrioColor:
          issuePrioColor?.mapToDomain() ?? const ProjectStatusColor(),
      statusColor: statusColor?.mapToDomain() ?? const ProjectStatusColor(),
    );
  }
}

extension RemoteIssuesListExtension on List<RemoteIssues> {
  List<Challenges> mapToDomain() => map((e) => e.mapToDomain()).toList();
}
