import 'package:equatable/equatable.dart';

class TaskBoardEnum extends Equatable {
  final int id;
  final String name;

  const TaskBoardEnum({
    this.id = 0,
    this.name = "",
  });

  @override
  List<Object?> get props => [id, name];

  TaskBoardEnum copyWith({
    int? id,
    String? name,
  }) {
    return TaskBoardEnum(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
