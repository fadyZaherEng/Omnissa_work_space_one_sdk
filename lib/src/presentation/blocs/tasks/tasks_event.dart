part of 'tasks_bloc.dart';

@immutable
sealed class TasksEvent {}

class GetTasksEvent extends TasksEvent {
  final int pageSize;
  final int skip;
  final bool isStart;
  final String searchValue;
  final String searchFilterDefination;

  final String sortColumnDirection;
  final String columnDirection;

  GetTasksEvent({
    required this.pageSize,
    required this.skip,
    this.isStart = false,
    required this.searchValue,
    required this.searchFilterDefination,
    required this.sortColumnDirection,
    required this.columnDirection,
  });
}
// class GetTaskInfoEvent extends TasksEvent {
//   final String id;
//   final int pageSize;
//   final int skip;
//
//   GetTaskInfoEvent({
//     required this.id,
//     required this.pageSize,
//     required this.skip,
//   });
// }

class SearchTaskEvent extends TasksEvent {
  final String search;

  SearchTaskEvent({required this.search});
}

class GetSortedTasksEvent extends TasksEvent {
  final Sort sort;

  GetSortedTasksEvent({
    required this.sort,
  });
}

class FilterTasksEvent extends TasksEvent {
  final Filter filter;

  FilterTasksEvent({required this.filter});
}

class TaskUpdateEvent extends TasksEvent {
  final RequestUpdateTasks requestUpdateTasks;
  final int pageSize;
  final int skip;

  TaskUpdateEvent({
    required this.requestUpdateTasks,
    required this.pageSize,
    required this.skip,
  });
}
