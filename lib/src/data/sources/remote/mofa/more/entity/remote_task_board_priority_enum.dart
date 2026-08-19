import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/domain/entities/home/task_enum.dart';

part 'remote_task_board_priority_enum.g.dart';

@JsonSerializable()
class RemoteTaskBoardPriorityEnum {
  final int? id;
  final String? name;

  const RemoteTaskBoardPriorityEnum({
    this.id = 0,
    this.name = "",
  });

  factory RemoteTaskBoardPriorityEnum.fromJson(Map<String, dynamic> json) =>
      _$RemoteTaskBoardPriorityEnumFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteTaskBoardPriorityEnumToJson(this);
}

extension RemoteTaskBoardPriorityEnumExtension on RemoteTaskBoardPriorityEnum {
  TaskBoardEnum mapToDomain() {
    return TaskBoardEnum(
      id: id ?? 0,
      name: name ?? "",
    );
  }
}

extension TaskListExtension on List<RemoteTaskBoardPriorityEnum> {
  List<TaskBoardEnum> mapToDomain() => map((e) => e.mapToDomain()).toList();
}
