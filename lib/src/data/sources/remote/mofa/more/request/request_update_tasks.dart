import 'package:json_annotation/json_annotation.dart';

part 'request_update_tasks.g.dart';

@JsonSerializable()
class RequestUpdateTasks {
  final Changes changes;
  final Tasks tasks;

  const RequestUpdateTasks({
    required this.changes,
    required this.tasks,
  });

  factory RequestUpdateTasks.fromJson(Map<String, dynamic> json) =>
      _$RequestUpdateTasksFromJson(json);

  Map<String, dynamic> toJson() => _$RequestUpdateTasksToJson(this);

  @override
  String toString() {
    return 'RequestUpdateTasks{changes: $changes, tasks: $tasks}';
  }
}

@JsonSerializable()
class Changes {
  final String actionType;

  const Changes({
    required this.actionType,
  });

  factory Changes.fromJson(Map<String, dynamic> json) =>
      _$ChangesFromJson(json);

  Map<String, dynamic> toJson() => _$ChangesToJson(this);

  @override
  toString() {
    return 'Changes{actionType: $actionType}';
  }
}

@JsonSerializable()
class Tasks {
  final List<Updated> updated;

  const Tasks({
    required this.updated,
  });

  factory Tasks.fromJson(Map<String, dynamic> json) => _$TasksFromJson(json);

  Map<String, dynamic> toJson() => _$TasksToJson(this);

  @override
  toString() {
    return 'Tasks{updated: $updated}';
  }
}

@JsonSerializable()
class Updated {
  final String Id;
  final int DraftPercentDone;
  final int Duration;
  final int DraftStatus;
  final int DraftPriority;
  final String AssignmentId;
  final String commnet;

  const Updated({
    required this.Id,
    required this.DraftPercentDone,
    required this.Duration,
    required this.DraftStatus,
    required this.DraftPriority,
    required this.AssignmentId,
    required this.commnet,
  });

  factory Updated.fromJson(Map<String, dynamic> json) =>
      _$UpdatedFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatedToJson(this);

  @override
  toString() {
    return 'Updated{Id: $Id, DraftPercentDone: $DraftPercentDone, Duration: $Duration, DraftStatus: $DraftStatus, DraftPriority:  $DraftPriority, AssignmentId: $AssignmentId , commnet: $commnet}';
  }
}
