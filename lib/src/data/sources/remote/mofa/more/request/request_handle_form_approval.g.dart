// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_handle_form_approval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestHandleFormApproval _$RequestHandleFormApprovalFromJson(
        Map<String, dynamic> json) =>
    RequestHandleFormApproval(
      TaskId: json['TaskId'] as String?,
      ActionName: json['ActionName'] as String?,
      Comment: json['Comment'] as String?,
    );

Map<String, dynamic> _$RequestHandleFormApprovalToJson(
        RequestHandleFormApproval instance) =>
    <String, dynamic>{
      'TaskId': instance.TaskId,
      'ActionName': instance.ActionName,
      'Comment': instance.Comment,
    };
