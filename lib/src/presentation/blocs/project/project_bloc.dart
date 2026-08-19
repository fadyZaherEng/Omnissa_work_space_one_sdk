import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/core/utils/check_filter_status.dart';
import 'package:mofa/src/domain/entities/home/department.dart';
import 'package:mofa/src/domain/entities/home/owner.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/home/status_model.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/domain/usecase/projects/get_all_projects_use_case.dart';
import 'package:mofa/src/domain/usecase/projects/get_project_departments_use_case.dart';
import 'package:mofa/src/domain/usecase/projects/get_project_owner_use_case.dart';
import 'package:mofa/src/domain/usecase/projects/get_project_status_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/get_sort_project_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/projects_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_project_use_case.dart';

part 'project_event.dart';

part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectsSortUseCase _projectsSortUseCase;
  final SetSortProjectUseCase _setSortProjectUseCase;
  final GetSortProjectUseCase _getSortProjectUseCase;
  final GetAllProjectsUseCase _getAllProjectsUseCase;
  final GetProjectDepartmentsUseCase _getProjectDepartmentsUseCase;
  final GetProjectStatusUseCase _getProjectStatusUseCase;
  final GetProjectOwnerUseCase _getProjectOwnerUseCase;

  ProjectBloc(
    this._projectsSortUseCase,
    this._setSortProjectUseCase,
    this._getSortProjectUseCase,
    this._getAllProjectsUseCase,
    this._getProjectDepartmentsUseCase,
    this._getProjectStatusUseCase,
    this._getProjectOwnerUseCase,
  ) : super(ProjectInitial()) {
    on<GetProjectsEvent>(_onGetProjectsEvent);
    on<SearchProjectEvent>(_onSearchProjectEvent);
    on<GetSortedProjectsEvent>(_onSortProjectEvent);
    on<FilterProjectsEvent>(_onFilterProjectsEvent);
  }

  final List<Project> _projects = [];

  FutureOr<void> _onGetProjectsEvent(
      GetProjectsEvent event, Emitter<ProjectState> emit) async {
    if (event.isStart) {
      emit(GetProjectsSkeletonState());
    } else {
      emit(GetProjectsLoadingState());
    }
    DataState<List<Department>> departments =
        await _getProjectDepartmentsUseCase();
    DataState<List<StatusModel>> status = await _getProjectStatusUseCase();
    DataState<List<GetOwner>> owner = await _getProjectOwnerUseCase();

    final int resolvedStatus = event.isFilter
        ? (event.status == null || event.status == -1 ? -1 : event.status!)
        : (-1);

    final String resolvedDepartmentId = event.isFilter
        ? (event.departmentId?.isEmpty ?? true ? "" : event.departmentId!)
        : ("");

    final String resolvedOwnerId = event.isFilter
        ? (event.owner?.isEmpty ?? true ? "" : event.owner!)
        : ("");

    DataState<List<Project>> projects = await _getAllProjectsUseCase(
      pageSize: event.pageSize,
      skip: event.skip,
      status: resolvedStatus,
      departmentId: resolvedDepartmentId,
      owner: resolvedOwnerId,
      searchFilterDefinition: event.searchFilterDefinition,
      searchValue: event.searchValue,
      sortColumnDirection: event.sortColumnDirection,
      columnDirection: event.columnDirection,
    );

    if (projects is DataSuccess) {
      _projects.clear();
      _projects.addAll(projects.data ?? []);
      emit(GetProjectsSuccessState(
        projects: _projects,
        departments: departments.data ?? [],
        status: status.data ?? [],
        owners: owner.data ?? [],
      ));
    } else if (projects is DataFailed) {
      emit(GetProjectsErrorState(errorMessage: projects.message ?? ''));
    }
  }

  // Helper to check if a field contains the search text
  bool _containsIgnoreCase(String value, String searchText) =>
      value.toLowerCase().contains(searchText);

  FutureOr<void> _onSearchProjectEvent(
      SearchProjectEvent event, Emitter<ProjectState> emit) async {
    emit(GetProjectsLoadingState());
    DataState<List<Department>> departments =
        await _getProjectDepartmentsUseCase();
    DataState<List<StatusModel>> status = await _getProjectStatusUseCase();
    DataState<List<GetOwner>> owner = await _getProjectOwnerUseCase();

    final searchText = event.search.trim().toLowerCase();
    if (searchText.isEmpty) {
      emit(GetProjectsSuccessState(
        projects: _projects,
        departments: departments.data ?? [],
        status: status.data ?? [],
        owners: owner.data ?? [],
      ));
    } else {
      final filteredProjects = _projects.where((project) {
        return _containsIgnoreCase(
                project.title.trim().toLowerCase().toString(), searchText) ||
            _containsIgnoreCase(
                project.managerName.trim().toLowerCase().toString(),
                searchText) ||
            _containsIgnoreCase(
                project.departmentName.trim().toLowerCase().toString(),
                searchText) ||
            _containsIgnoreCase(
                project.currentProjectPhaseStr.trim().toLowerCase().toString(),
                searchText) ||
            _containsIgnoreCase(
                project.currentProjectStageStr.trim().toLowerCase().toString(),
                searchText) ||
            _containsIgnoreCase(
                project.projectEndDate.trim().toLowerCase().toString(),
                searchText) ||
            _containsIgnoreCase(
                project.id.trim().toLowerCase().toString(), searchText) ||
            _containsIgnoreCase(
                project.projectStartDate.trim().toString().trim().toString(),
                searchText);
      }).toList();

      emit(GetProjectsSuccessState(
        projects: filteredProjects,
        departments: departments.data ?? [],
        status: status.data ?? [],
        owners: owner.data ?? [],
      ));
    }
  }

  FutureOr<void> _onSortProjectEvent(
      GetSortedProjectsEvent event, Emitter<ProjectState> emit) {
    // emit(GetProjectsLoadingState());
    _setSortProjectUseCase(event.sort);
    final sort = event.sort;
    // final sortedProjects = _projectsSortUseCase.sortProjects(_projects, sort);
    // emit(SortProjectState(projects: sortedProjects));
  }

  FutureOr<void> _onFilterProjectsEvent(
      FilterProjectsEvent event, Emitter<ProjectState> emit) {
    emit(GetProjectsLoadingState());
    final Filter filter = event.filter;

    final filteredProjects = _projects.where((project) {
      final matchesStatus = project.projectStatusStr
          .toLowerCase()
          .trim()
          .contains(filter.statusName.toLowerCase().trim());
      final matchesDepartment = project.departmentName
          .toLowerCase()
          .trim()
          .contains(filter.departmentName.toLowerCase().trim());
      final matchesStartDate =
          _isMoreThenOrEqualDate(filter.startDate, project.projectStartDate);
      final matchesEndDate =
          _isLessThenDate(filter.endDate, project.projectEndDate);

      return checkFilterStatus(
        matchesStatus,
        matchesDepartment,
        matchesStartDate,
        matchesEndDate,
        filter,
      );
    }).toList();

    emit(FilterProjectsState(projects: filteredProjects));
  }

  bool _isMoreThenOrEqualDate(String date1, String date2) {
    final d1 = DateTime.tryParse(date1);
    final d2 = DateTime.tryParse(date2);
    if (d1 == null || d2 == null) return false;

    final d1Only = DateTime(d1.year, d1.month, d1.day);
    final d2Only = DateTime(d2.year, d2.month, d2.day);

    return d1Only.isAfter(d2Only) || d1Only.isAtSameMomentAs(d2Only);
  }

  bool _isLessThenDate(String date1, String date2) {
    final d1 = DateTime.tryParse(date1);
    final d2 = DateTime.tryParse(date2);
    if (d1 == null || d2 == null) return false;

    final d1Only = DateTime(d1.year, d1.month, d1.day);
    final d2Only = DateTime(d2.year, d2.month, d2.day);

    return d1Only.isBefore(d2Only);
  }
}
