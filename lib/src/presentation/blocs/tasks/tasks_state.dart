part of 'tasks_bloc.dart';

@immutable
sealed class TasksState {}

final class TasksInitial extends TasksState {}

final class GetTasksSuccessState extends TasksState {
  final List<Task> tasks;
  final List<TaskBoardEnum> taskStatus;
  final List<TaskBoardEnum> taskPriority;

  GetTasksSuccessState({
    required this.tasks,
    this.taskStatus = const [],
    this.taskPriority = const [],
  });
}

final class GetTaskInfoLoadingState extends TasksState {}

// final class GetTaskInfoSuccessState extends TasksState {
//   final Task task;
//
//   GetTaskInfoSuccessState(this.task);
// }
// final class GetTaskInfoErrorState extends TasksState {
//   final String errorMessage;
//
//   GetTaskInfoErrorState(this.errorMessage);
// }
//
final class GetTasksErrorState extends TasksState {
  final String errorMessage;

  GetTasksErrorState(this.errorMessage);
}

final class GetTasksLoadingState extends TasksState {}

final class SearchTasksSuccessState extends TasksState {
  final List<Task> tasks;

  SearchTasksSuccessState(this.tasks);
}

final class SortTasksState extends TasksState {
  final List<Task> tasks;

  SortTasksState({required this.tasks});
}

final class FilterTasksState extends TasksState {
  final List<Task> tasks;

  FilterTasksState({required this.tasks});
}

final class TaskUpdatesLoadingState extends TasksState {}

final class TaskUpdatesSuccessState extends TasksState {
  final String message;

  TaskUpdatesSuccessState(this.message);
}

final class TaskUpdatesErrorState extends TasksState {
  final String errorMessage;

  TaskUpdatesErrorState(this.errorMessage);
}
