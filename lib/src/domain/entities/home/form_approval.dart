import 'package:equatable/equatable.dart';

class FormApproval extends Equatable {
  final String id;
  final String workflowInstanceId;
  final String taskId;
  final int status;
  final String requestId;
  final String createdBy;
  final String created;
  final String creationDate;
  final String pathRequest;
  final String currentStage;
  final String projectName;
  final String projectManager;
  final String assignToName;
  final String workflowFormName;
  final String assignToRole;
  final bool isDeadline;
  final int workflowCategory;
  final bool hasRequiredAttachments;
  final List<ActionsList> actionsList;
  final Details details;

  const FormApproval({
    this.id = '',
    this.workflowInstanceId = '',
    this.taskId = '',
    this.status = 0,
    this.requestId = '',
    this.createdBy = '',
    this.created = '',
    this.creationDate = '',
    this.pathRequest = '',
    this.currentStage = '',
    this.projectName = '',
    this.projectManager = '',
    this.assignToName = '',
    this.assignToRole = '',
    this.isDeadline = false,
    this.actionsList = const [],
    this.details = const Details(),
    this.workflowFormName = '',
    this.hasRequiredAttachments = false,
    this.workflowCategory = 0,
  });

  @override
  List<Object?> get props => [
        id,
        workflowInstanceId,
        taskId,
        status,
        requestId,
        createdBy,
        created,
        creationDate,
        pathRequest,
        currentStage,
        projectName,
        projectManager,
        assignToName,
        assignToRole,
        isDeadline,
        actionsList,
        details,
        workflowFormName,
        hasRequiredAttachments,
        workflowCategory,
      ];
}

class ActionsList extends Equatable {
  final String id;
  final String nameEn;
  final String nameAr;
  final String name;
  final String color;
  final String backgroundColor;
  final int order;
  final bool isRequiredComment;
  final bool isRequiredAttachments;

  const ActionsList({
    this.id = '',
    this.nameEn = '',
    this.nameAr = '',
    this.name = '',
    this.color = '',
    this.backgroundColor = '',
    this.order = 0,
    this.isRequiredComment = false,
    this.isRequiredAttachments = false,
  });

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameAr,
        name,
        color,
        backgroundColor,
        order,
        isRequiredComment,
        isRequiredAttachments,
      ];
}

class Details extends Equatable {
  final String info;

  const Details({
    this.info = '',
  });

  @override
  List<Object?> get props => [
        info,
      ];
}
