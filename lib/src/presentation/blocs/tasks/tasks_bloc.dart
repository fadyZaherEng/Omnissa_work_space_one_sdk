import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/core/utils/check_filter_status.dart';
import 'package:mofa/src/core/utils/convert_string_to_date_format.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_update_tasks.dart';
import 'package:mofa/src/domain/entities/home/task.dart';
import 'package:mofa/src/domain/entities/home/task_enum.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/domain/usecase/more/get_task_info_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_task_priority_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_task_status_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_task_updates_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_tasks_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_tasks_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/tasks_sort_use_case.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TasksSortUseCase _tasksSortUseCase;
  final SetSortTasksUseCase _setSortTasksUseCase;
  final GetTasksUseCase _getTasksUseCase;
  final GetTaskStatusUseCase _getTaskStatusUseCase;
  final GetTaskPriorityUseCase _getTaskPriorityUseCase;
  final GetTaskUpdatesUseCase _getTaskUpdatesUseCase;
  final GetTaskInfoUseCase _getTaskInfoUseCase;

  TasksBloc(
    this._tasksSortUseCase,
    this._setSortTasksUseCase,
    this._getTasksUseCase,
    this._getTaskPriorityUseCase,
    this._getTaskStatusUseCase,
    this._getTaskUpdatesUseCase,
    this._getTaskInfoUseCase,
  ) : super(TasksInitial()) {
    on<GetTasksEvent>(_onGetTasksEvent);
    on<SearchTaskEvent>(_onSearchProjectEvent);
    on<FilterTasksEvent>(_onFilterTaskEvent);
    on<GetSortedTasksEvent>(_onGetSortedTasksEvent);
    on<TaskUpdateEvent>(_onTaskUpdateEvent);
    // on<GetTaskInfoEvent>(_onGetTaskInfoEvent);
  }

  //
  // FutureOr<void> _onGetTaskInfoEvent(
  //     GetTaskInfoEvent event, Emitter<TasksState> emit) async {
  //   emit(GetTaskInfoLoadingState());
  //   DataState<RemoteMilstoneDetails> response = await _getTaskInfoUseCase(
  //     id: event.id,
  //     pageSize: event.pageSize,
  //     skip: event.skip,
  //   );
  //   if (response is DataSuccess) {
  //     emit(GetTaskInfoSuccessState(response.data ?? const RemoteMilstoneDetails()));
  //   } else if (response is DataFailed) {
  //     emit(GetTaskInfoErrorState(response.message ?? ""));
  //   }
  // }

  final List<Task> _tasks = [];

  FutureOr<void> _onGetTasksEvent(
      GetTasksEvent event, Emitter<TasksState> emit) async {
    if (event.isStart) {
      emit(GetTasksLoadingState());
    }
    DataState<List<Task>> response = await _getTasksUseCase(
      pageSize: event.pageSize,
      skip: event.skip,
      searchValue: event.searchValue,
      searchFilterDefinition: event.searchFilterDefination,
      columnDirection: event.columnDirection,
      sortColumnDirection: event.sortColumnDirection,
    );
    DataState<List<TaskBoardEnum>> responsePriority =
        await _getTaskPriorityUseCase();
    DataState<List<TaskBoardEnum>> responseStatus =
        await _getTaskStatusUseCase();
    if (response is DataSuccess) {
      _tasks.clear();
      _tasks.addAll(response.data ?? []);
      emit(GetTasksSuccessState(
        tasks: _tasks,
        taskPriority: responsePriority.data ?? [],
        taskStatus: responseStatus.data ?? [],
      ));
    } else if (response is DataFailed) {
      emit(GetTasksErrorState(response.message ?? ""));
    }
  }

  // Helper to check if a field contains the search text
  bool _containsIgnoreCase(String value, String searchText) =>
      value.toLowerCase().contains(searchText);

  FutureOr<void> _onSearchProjectEvent(
      SearchTaskEvent event, Emitter<TasksState> emit) {
    emit(GetTasksLoadingState());
    final searchText = event.search.trim().toLowerCase();
    if (searchText.isEmpty) {
      emit(GetTasksSuccessState(tasks: _tasks));
    } else {
      final filteredTasks = _tasks.where((task) {
        return _containsIgnoreCase(
                task.name.toLowerCase().trim(), searchText) ||
            _containsIgnoreCase(
                task.taskOwnerStr.toLowerCase().trim(), searchText) ||
            _containsIgnoreCase(
                task.wfStatus.toLowerCase().trim(), searchText) ||
            _containsIgnoreCase(
                task.taskEndDate.toLowerCase().trim(), searchText) ||
            _containsIgnoreCase(
                task.taskStartDate.toLowerCase().trim(), searchText) ||
            _containsIgnoreCase(
                task.achievement.name.toLowerCase().trim().toString(),
                searchText) ||
            _containsIgnoreCase(task.id.toLowerCase().trim(), searchText) ||
            _containsIgnoreCase(
                task.statusColor.toString().toLowerCase().trim(), searchText);
      }).toList();

      emit(SearchTasksSuccessState(filteredTasks));
    }
  }

  FutureOr<void> _onGetSortedTasksEvent(
      GetSortedTasksEvent event, Emitter<TasksState> emit) {
    // emit(GetTasksLoadingState());
    _setSortTasksUseCase(event.sort);
    // final sort = event.sort;
    // final sortedTasks = _tasksSortUseCase.sortTasks(_tasks, sort);
    // emit(SortTasksState(tasks: sortedTasks));
  }

  FutureOr<void> _onFilterTaskEvent(
      FilterTasksEvent event, Emitter<TasksState> emit) {
    emit(GetTasksLoadingState());

    final Filter filter = event.filter;

    final filteredProjects = _tasks.where((task) {
      final matchesStatus = task.wfStatus
          .trim()
          .toLowerCase()
          .contains(filter.statusName.trim().toLowerCase());
      final matchesDepartment = task.assignedDepartmentStr
          .trim()
          .toLowerCase()
          .contains(filter.departmentName.trim().toLowerCase());
      final matchesStartDate =
          isMoreThenOrEqualDate(filter.startDate, task.taskStartDate);
      final matchesEndDate = isLessThenDate(filter.endDate, task.taskEndDate);

      return checkFilterStatus(
        matchesStatus,
        matchesDepartment,
        matchesStartDate,
        matchesEndDate,
        filter,
      );
    }).toList();

    emit(FilterTasksState(tasks: filteredProjects));
  }

  FutureOr<void> _onTaskUpdateEvent(
      TaskUpdateEvent event, Emitter<TasksState> emit) async {
    emit(TaskUpdatesLoadingState());
    DataState<dynamic> response = await _getTaskUpdatesUseCase(
      requestUpdateTasks: event.requestUpdateTasks,
    );
    if (response is DataSuccess) {
      emit(TaskUpdatesSuccessState(response.data ?? ""));
    } else if (response is DataFailed) {
      emit(TaskUpdatesErrorState(response.message ?? ""));
    }
  }
}
