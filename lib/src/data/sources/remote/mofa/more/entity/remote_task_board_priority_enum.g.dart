// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_task_board_priority_enum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteTaskBoardPriorityEnum _$RemoteTaskBoardPriorityEnumFromJson(
        Map<String, dynamic> json) =>
    RemoteTaskBoardPriorityEnum(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteTaskBoardPriorityEnumToJson(
        RemoteTaskBoardPriorityEnum instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
