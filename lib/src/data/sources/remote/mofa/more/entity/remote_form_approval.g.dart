// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_form_approval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteFormApproval _$RemoteFormApprovalFromJson(Map<String, dynamic> json) =>
    RemoteFormApproval(
      id: json['id'] as String? ?? '',
      workflowInstanceId: json['workflowInstanceId'] as String? ?? '',
      taskId: json['taskId'] as String? ?? '',
      status: (json['status'] as num?)?.toInt() ?? 0,
      requestId: json['requestId'] as String? ?? '',
      createdBy: json['createdBy'] as String? ?? '',
      created: json['created'] as String? ?? '',
      creationDate: json['creationDate'] as String? ?? '',
      pathRequest: json['pathRequest'] as String? ?? '',
      currentStage: json['currentStage'] as String? ?? '',
      projectName: json['projectName'] as String? ?? '',
      projectManager: json['projectManager'] as String? ?? '',
      assignToName: json['assignToName'] as String? ?? '',
      assignToRole: json['assignToRole'] as String? ?? '',
      isDeadline: json['isDeadline'] as bool? ?? false,
      actionsList: (json['actionsList'] as List<dynamic>?)
              ?.map(
                  (e) => RemoteActionsList.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      details: json['details'] == null
          ? const RemoteDetails()
          : RemoteDetails.fromJson(json['details'] as Map<String, dynamic>),
      workflowFormName: json['workflowFormName'] as String? ?? '',
      workflowCategory: (json['workflowCategory'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RemoteFormApprovalToJson(RemoteFormApproval instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workflowInstanceId': instance.workflowInstanceId,
      'taskId': instance.taskId,
      'status': instance.status,
      'workflowCategory': instance.workflowCategory,
      'requestId': instance.requestId,
      'createdBy': instance.createdBy,
      'created': instance.created,
      'creationDate': instance.creationDate,
      'pathRequest': instance.pathRequest,
      'currentStage': instance.currentStage,
      'projectName': instance.projectName,
      'workflowFormName': instance.workflowFormName,
      'projectManager': instance.projectManager,
      'assignToName': instance.assignToName,
      'assignToRole': instance.assignToRole,
      'isDeadline': instance.isDeadline,
      'actionsList': instance.actionsList,
      'details': instance.details,
    };

RemoteActionsList _$RemoteActionsListFromJson(Map<String, dynamic> json) =>
    RemoteActionsList(
      id: json['id'] as String? ?? '',
      nameEn: json['nameEn'] as String? ?? '',
      nameAr: json['nameAr'] as String? ?? '',
      name: json['name'] as String? ?? '',
      color: json['color'] as String? ?? '',
      backgroundColor: json['backgroundColor'] as String? ?? '',
      order: (json['order'] as num?)?.toInt() ?? 0,
      isRequiredComment: json['isRequiredComment'] as bool? ?? false,
      isRequiredAttachments: json['isRequiredAttachments'] as bool? ?? false,
    );

Map<String, dynamic> _$RemoteActionsListToJson(RemoteActionsList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameEn': instance.nameEn,
      'nameAr': instance.nameAr,
      'name': instance.name,
      'color': instance.color,
      'backgroundColor': instance.backgroundColor,
      'order': instance.order,
      'isRequiredComment': instance.isRequiredComment,
      'isRequiredAttachments': instance.isRequiredAttachments,
    };

RemoteDetails _$RemoteDetailsFromJson(Map<String, dynamic> json) =>
    RemoteDetails(
      info: json['info'] as String? ?? '',
    );

Map<String, dynamic> _$RemoteDetailsToJson(RemoteDetails instance) =>
    <String, dynamic>{
      'info': instance.info,
    };
