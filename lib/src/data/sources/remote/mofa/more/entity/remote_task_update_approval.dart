import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/domain/entities/home/task_update_approval.dart';

part 'remote_task_update_approval.g.dart';

@JsonSerializable()
class RemoteTaskUpdateApproval {
  final String? id;
  final String? projectID;
  final String? projectName;
  final String? taskId;
  final String? taskStartDate;
  final String? taskEndDate;
  final String? taskName;
  final String? taskpercentDone;
  final String? taskPriorityStr;
  final String? taskStatusStr;
  final int? taskPriority;
  final String? requestId;
  final String? assignmentPriorityStr;
  final String? assignmentStatusStr;
  final int? assignmentpercentDone;
  final String? assignmentComments;
  final int? wfStatus;
  final String? createdBy;
  final String? created;
  final String? creationDate;
  final String? projectManager;

  const RemoteTaskUpdateApproval({
    this.id = '',
    this.projectID = '',
    this.projectName = '',
    this.taskId = '',
    this.taskStartDate = '',
    this.taskEndDate = '',
    this.taskName = '',
    this.taskpercentDone = '',
    this.taskPriorityStr = '',
    this.taskStatusStr = '',
    this.taskPriority = 0,
    this.requestId = '',
    this.assignmentPriorityStr = '',
    this.assignmentStatusStr = '',
    this.assignmentpercentDone = 0,
    this.assignmentComments = '',
    this.wfStatus = 0,
    this.createdBy = '',
    this.created = '',
    this.creationDate = '',
    this.projectManager = '',
  });

  factory RemoteTaskUpdateApproval.fromJson(Map<String, dynamic> json) =>
      _$RemoteTaskUpdateApprovalFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteTaskUpdateApprovalToJson(this);
}

extension RemoteTaskUpdateApprovalMapper on RemoteTaskUpdateApproval {
  TaskUpdateApproval mapToDomain() => TaskUpdateApproval(
        id: id ?? '',
        projectID: projectID ?? '',
        projectName: projectName ?? '',
        taskId: taskId ?? '',
        taskStartDate: taskStartDate ?? '',
        taskEndDate: taskEndDate ?? '',
        taskName: taskName ?? '',
        taskpercentDone: taskpercentDone ?? '',
        taskPriorityStr: taskPriorityStr ?? '',
        taskStatusStr: taskStatusStr ?? '',
        taskPriority: taskPriority ?? 0,
        requestId: requestId ?? '',
        assignmentPriorityStr: assignmentPriorityStr ?? '',
        assignmentStatusStr: assignmentStatusStr ?? '',
        assignmentpercentDone: assignmentpercentDone ?? 0,
        assignmentComments: assignmentComments ?? '',
        wfStatus: wfStatus ?? 0,
        createdBy: createdBy ?? '',
        created: created ?? '',
        creationDate: creationDate ?? '',
        projectManager: projectManager ?? '',
      );
}

extension ListRemoteTaskUpdateApprovalMapper on List<RemoteTaskUpdateApproval> {
  List<TaskUpdateApproval> mapToDomain() =>
      map((e) => e.mapToDomain()).toList();
}
