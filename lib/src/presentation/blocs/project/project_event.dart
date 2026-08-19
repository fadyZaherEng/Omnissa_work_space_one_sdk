part of 'project_bloc.dart';

@immutable
sealed class ProjectEvent {}

class GetProjectsEvent extends ProjectEvent {
  final int pageSize;
  final int skip;
  final bool isStart;
  final int? status;
  final String? departmentId;
  final String? owner;
  final bool isFilter;
  final String searchFilterDefinition;
  final String searchValue;
  final String sortColumnDirection;
  final String columnDirection;

  GetProjectsEvent({
    required this.pageSize,
    required this.skip,
    this.isStart = false,
    this.status,
    this.departmentId,
    this.owner,
    this.isFilter = false,
    this.searchFilterDefinition = "",
    this.searchValue = "",
    required this.sortColumnDirection,
    required this.columnDirection,
  });
}

class SearchProjectEvent extends ProjectEvent {
  final String search;

  SearchProjectEvent({
    required this.search,
  });
}

class GetSortedProjectsEvent extends ProjectEvent {
  final Sort sort;

  GetSortedProjectsEvent({
    required this.sort,
  });
}

class FilterProjectsEvent extends ProjectEvent {
  final Filter filter;

  FilterProjectsEvent({required this.filter});
}
