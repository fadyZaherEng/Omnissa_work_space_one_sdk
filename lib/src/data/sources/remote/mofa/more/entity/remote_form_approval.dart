import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/domain/entities/home/form_approval.dart';

part 'remote_form_approval.g.dart';

@JsonSerializable()
class RemoteFormApproval {
  final String? id;
  final String? workflowInstanceId;
  final String? taskId;
  final int? status;
  final int? workflowCategory;
  final String? requestId;
  final String? createdBy;
  final String? created;
  final String? creationDate;
  final String? pathRequest;
  final String? currentStage;
  final String? projectName;
  final String? workflowFormName;
  final String? projectManager;
  final String? assignToName;
  final String? assignToRole;
  final bool? isDeadline;
  final List<RemoteActionsList>? actionsList;
  final RemoteDetails? details;

  const RemoteFormApproval({
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
    this.details = const RemoteDetails(),
    this.workflowFormName = '',
    this.workflowCategory = 0,
  });

  factory RemoteFormApproval.fromJson(Map<String, dynamic> json) =>
      _$RemoteFormApprovalFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteFormApprovalToJson(this);
}

extension RemoteFormApprovalX on RemoteFormApproval {
  FormApproval mapToDomain() {
    return FormApproval(
      id: id ?? '',
      workflowInstanceId: workflowInstanceId ?? '',
      taskId: taskId ?? '',
      status: status ?? 0,
      requestId: requestId ?? '',
      createdBy: createdBy ?? '',
      created: created ?? '',
      creationDate: creationDate ?? '',
      pathRequest: pathRequest ?? '',
      currentStage: currentStage ?? '',
      projectName: projectName ?? '',
      projectManager: projectManager ?? '',
      assignToName: assignToName ?? '',
      assignToRole: assignToRole ?? '',
      isDeadline: isDeadline ?? false,
      actionsList: actionsList?.map((e) => e.mapToDomain()).toList() ?? [],
      details: details?.mapToDomain() ?? const Details(),
      workflowFormName: workflowFormName ?? '',
      workflowCategory: workflowCategory ?? 0,
    );
  }
}

extension RemoteFormApprovalListX on List<RemoteFormApproval> {
  List<FormApproval> mapToDomain() => map((e) => e.mapToDomain()).toList();
}

@JsonSerializable()
class RemoteActionsList {
  final String? id;
  final String? nameEn;
  final String? nameAr;
  final String? name;
  final String? color;
  final String? backgroundColor;
  final int? order;
  final bool? isRequiredComment;
  final bool? isRequiredAttachments;

  const RemoteActionsList({
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

  factory RemoteActionsList.fromJson(Map<String, dynamic> json) =>
      _$RemoteActionsListFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteActionsListToJson(this);
}

extension RemoteActionsListX on RemoteActionsList {
  ActionsList mapToDomain() {
    return ActionsList(
      id: id ?? '',
      nameEn: nameEn ?? '',
      nameAr: nameAr ?? '',
      name: name ?? '',
      color: color ?? '',
      backgroundColor: backgroundColor ?? '',
      order: order ?? 0,
      isRequiredComment: isRequiredComment ?? false,
      isRequiredAttachments: isRequiredAttachments ?? false,
    );
  }
}

@JsonSerializable()
class RemoteDetails {
  final String? info;

  const RemoteDetails({
    this.info = '',
  });

  factory RemoteDetails.fromJson(Map<String, dynamic> json) =>
      _$RemoteDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteDetailsToJson(this);
}

extension RemoteDetailsX on RemoteDetails {
  Details mapToDomain() {
    return Details(info: info ?? '');
  }
}
