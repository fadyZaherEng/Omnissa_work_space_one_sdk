import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_save_project_latest.dart';
import 'package:mofa/src/domain/entities/home/project_details.dart';
import 'package:mofa/src/domain/usecase/more/save_project_latest_use_case.dart';
import 'package:mofa/src/domain/usecase/projects/get_project_full_details_use_case.dart';

part 'project_details_event.dart';

part 'project_details_state.dart';

class ProjectDetailsBloc
    extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  final GetProjectFullDetailsUseCase _getProjectFullDetailsUseCase;
  final SaveProjectLatestUseCase _saveProjectLatestUseCase;

  ProjectDetailsBloc(
    this._getProjectFullDetailsUseCase,
    this._saveProjectLatestUseCase,
  ) : super(ProjectDetailsInitial()) {
    on<GetProjectDetailsEvent>(_onGetProjectDetailsEvent);
    on<SaveProjectLatestEvent>(_onSaveProjectLatestEvent);
  }

  FutureOr<void> _onGetProjectDetailsEvent(
      GetProjectDetailsEvent event, Emitter<ProjectDetailsState> emit) async {
    if (!event.isPagination) {
      emit(ProjectDetailsLoadingState());
    }
    DataState<ProjectDetails> projectDetails =
        await _getProjectFullDetailsUseCase(
      projectId: event.projectId,
      searchValue: event.searchValue,
      draw: event.draw,
      pageSize: event.pageSize,
      skip: event.skip,
    );
    if (projectDetails is DataSuccess) {
      emit(
        ProjectDetailsSuccessState(
          projectDetails: projectDetails.data ?? const ProjectDetails(),
          isPagination: event.isPagination,
        ),
      );
    } else {
      emit(ProjectDetailsErrorState(message: projectDetails.message ?? ""));
    }
  }

  FutureOr<void> _onSaveProjectLatestEvent(
      SaveProjectLatestEvent event, Emitter<ProjectDetailsState> emit) async {
    emit(SaveProjectLatestLoadingState());
    DataState dataState = await _saveProjectLatestUseCase(
        requestSaveProjectLatest: event.requestSaveProjectLatest);
    if (dataState is DataSuccess) {
      emit(SaveProjectLatestSuccessState(message: dataState.message ?? ""));
    } else {
      emit(SaveProjectLatestErrorState(message: dataState.message ?? ""));
    }
  }
}
