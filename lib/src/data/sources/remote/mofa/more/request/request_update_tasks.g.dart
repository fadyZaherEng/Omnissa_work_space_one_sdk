// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_update_tasks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestUpdateTasks _$RequestUpdateTasksFromJson(Map<String, dynamic> json) =>
    RequestUpdateTasks(
      changes: Changes.fromJson(json['changes'] as Map<String, dynamic>),
      tasks: Tasks.fromJson(json['tasks'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequestUpdateTasksToJson(RequestUpdateTasks instance) =>
    <String, dynamic>{
      'changes': instance.changes,
      'tasks': instance.tasks,
    };

Changes _$ChangesFromJson(Map<String, dynamic> json) => Changes(
      actionType: json['actionType'] as String,
    );

Map<String, dynamic> _$ChangesToJson(Changes instance) => <String, dynamic>{
      'actionType': instance.actionType,
    };

Tasks _$TasksFromJson(Map<String, dynamic> json) => Tasks(
      updated: (json['updated'] as List<dynamic>)
          .map((e) => Updated.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TasksToJson(Tasks instance) => <String, dynamic>{
      'updated': instance.updated,
    };

Updated _$UpdatedFromJson(Map<String, dynamic> json) => Updated(
      Id: json['Id'] as String,
      DraftPercentDone: (json['DraftPercentDone'] as num).toInt(),
      Duration: (json['Duration'] as num).toInt(),
      DraftStatus: (json['DraftStatus'] as num).toInt(),
      DraftPriority: (json['DraftPriority'] as num).toInt(),
      AssignmentId: json['AssignmentId'] as String,
      commnet: json['commnet'] as String,
    );

Map<String, dynamic> _$UpdatedToJson(Updated instance) => <String, dynamic>{
      'Id': instance.Id,
      'DraftPercentDone': instance.DraftPercentDone,
      'Duration': instance.Duration,
      'DraftStatus': instance.DraftStatus,
      'DraftPriority': instance.DraftPriority,
      'AssignmentId': instance.AssignmentId,
      'commnet': instance.commnet,
    };
