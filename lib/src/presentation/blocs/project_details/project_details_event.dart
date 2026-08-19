part of 'project_details_bloc.dart';

@immutable
sealed class ProjectDetailsEvent {}

class GetProjectDetailsEvent extends ProjectDetailsEvent {
  final String projectId;
  final String searchValue;
  final String draw;
  final int pageSize;
  final int skip;
  final bool isPagination;

  GetProjectDetailsEvent({
    required this.projectId,
    required this.searchValue,
    required this.draw,
    required this.skip,
    required this.pageSize,
    required this.isPagination,
  });
}

class SaveProjectLatestEvent extends ProjectDetailsEvent {
  final RequestSaveProjectLatest requestSaveProjectLatest;
  SaveProjectLatestEvent({
    required this.requestSaveProjectLatest,
  });
}
