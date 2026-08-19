part of 'project_details_bloc.dart';

@immutable
sealed class ProjectDetailsState {}

final class ProjectDetailsInitial extends ProjectDetailsState {}

final class ProjectDetailsLoadingState extends ProjectDetailsState {}

final class ProjectDetailsSuccessState extends ProjectDetailsState {
  final ProjectDetails projectDetails;
  final bool isPagination;

  ProjectDetailsSuccessState({
    required this.projectDetails,
    required this.isPagination,
  });
}

final class ProjectDetailsErrorState extends ProjectDetailsState {
  final String message;

  ProjectDetailsErrorState({
    required this.message,
  });
}

final class SaveProjectLatestLoadingState extends ProjectDetailsState {}

final class SaveProjectLatestSuccessState extends ProjectDetailsState {
  final String message;

  SaveProjectLatestSuccessState({
    required this.message,
  });
}

final class SaveProjectLatestErrorState extends ProjectDetailsState {
  final String message;

  SaveProjectLatestErrorState({
    required this.message,
  });
}
