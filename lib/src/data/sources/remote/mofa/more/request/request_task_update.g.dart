// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_task_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestTaskUpdate _$RequestTaskUpdateFromJson(Map<String, dynamic> json) =>
    RequestTaskUpdate(
      wfTaskId: json['wfTaskId'] as String?,
      recordId: json['recordId'] as String?,
      taskId: json['taskId'] as String?,
      comment: json['comment'] as String?,
      isApproved: json['isApproved'] as bool?,
    );

Map<String, dynamic> _$RequestTaskUpdateToJson(RequestTaskUpdate instance) =>
    <String, dynamic>{
      'wfTaskId': instance.wfTaskId,
      'recordId': instance.recordId,
      'taskId': instance.taskId,
      'comment': instance.comment,
      'isApproved': instance.isApproved,
    };
