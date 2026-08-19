// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_work_flow_history_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteWorkFlowHistoryList _$RemoteWorkFlowHistoryListFromJson(
        Map<String, dynamic> json) =>
    RemoteWorkFlowHistoryList(
      stage: json['stage'] as String? ?? '',
      actionEn: json['actionEn'] as String? ?? '',
      action: json['action'] as String? ?? '',
      comments: json['comments'] as String? ?? '',
      projectManagerEmail: json['projectManagerEmail'] as String? ?? '',
      projectManagerName: json['projectManagerName'] as String? ?? '',
      nickName: json['nickName'] as String? ?? '',
      departmentName: json['departmentName'] as String? ?? '',
      otherDetails: json['otherDetails'] as String? ?? '',
      createdBy: json['createdBy'] as String? ?? '',
      createdByName: json['createdByName'] as String? ?? '',
      creationDateStr: json['creationDateStr'] as String? ?? '',
      creationDate: json['creationDate'] as String? ?? '',
    );

Map<String, dynamic> _$RemoteWorkFlowHistoryListToJson(
        RemoteWorkFlowHistoryList instance) =>
    <String, dynamic>{
      'stage': instance.stage,
      'actionEn': instance.actionEn,
      'action': instance.action,
      'comments': instance.comments,
      'projectManagerEmail': instance.projectManagerEmail,
      'projectManagerName': instance.projectManagerName,
      'nickName': instance.nickName,
      'departmentName': instance.departmentName,
      'otherDetails': instance.otherDetails,
      'createdBy': instance.createdBy,
      'createdByName': instance.createdByName,
      'creationDateStr': instance.creationDateStr,
      'creationDate': instance.creationDate,
    };
