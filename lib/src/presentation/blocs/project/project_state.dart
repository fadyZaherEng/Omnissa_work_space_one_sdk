part of 'project_bloc.dart';

@immutable
sealed class ProjectState {}

final class ProjectInitial extends ProjectState {}

final class GetProjectsLoadingState extends ProjectState {}

final class GetProjectsSkeletonState extends ProjectState {}

final class GetProjectsSuccessState extends ProjectState {
  final List<Project> projects;
  final List<StatusModel> status;
  final List<Department> departments;
  final List<GetOwner> owners;

  GetProjectsSuccessState({
    required this.projects,
    required this.status,
    required this.departments,
    required this.owners,
  });
}

final class GetProjectsErrorState extends ProjectState {
  final String errorMessage;

  GetProjectsErrorState({required this.errorMessage});
}

final class SearchProjectState extends ProjectState {
  final List<Project> projects;

  SearchProjectState({required this.projects});
}

final class SortProjectState extends ProjectState {
  final List<Project> projects;

  SortProjectState({required this.projects});
}

final class FilterProjectsState extends ProjectState {
  final List<Project> projects;

  FilterProjectsState({required this.projects});
}
