import 'package:equatable/equatable.dart';

class TaskUpdateApproval extends Equatable {
  final String id;
  final String projectID;
  final String projectName;
  final String taskId;
  final String taskStartDate;
  final String taskEndDate;
  final String taskName;
  final String projectManager;
  final String taskpercentDone;
  final String taskPriorityStr;
  final String taskStatusStr;
  final int taskPriority;
  final String requestId;
  final String assignmentPriorityStr;
  final String assignmentStatusStr;
  final int assignmentpercentDone;
  final String assignmentComments;
  final int wfStatus;
  final String createdBy;
  final String created;
  final String creationDate;

  const TaskUpdateApproval({
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

  @override
  List<Object?> get props => [
        id,
        projectID,
        projectName,
        taskId,
        taskStartDate,
        taskEndDate,
        taskName,
        taskpercentDone,
        taskPriorityStr,
        taskStatusStr,
        taskPriority,
        requestId,
        assignmentPriorityStr,
        assignmentStatusStr,
        assignmentpercentDone,
        assignmentComments,
        wfStatus,
        createdBy,
        created,
        creationDate,
        projectManager,
      ];
}
