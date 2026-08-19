import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/department.dart';
import 'package:mofa/src/domain/entities/home/home_static.dart';
import 'package:mofa/src/domain/entities/home/status_model.dart';
import 'package:mofa/src/domain/entities/home/user_info.dart';
import 'package:mofa/src/domain/usecase/home/get_current_user_info_use_case.dart';
import 'package:mofa/src/domain/usecase/home/get_departments_use_case.dart';
import 'package:mofa/src/domain/usecase/home/get_home_statistics_use_case.dart';
import 'package:mofa/src/domain/usecase/home/get_status_use_case.dart';

part 'home_event.dart';

part 'home_state.dart';

List<Department> departmentsStore = [];
List<StatusModel> statusStore = [];
CurrentUserInfo currentUser = const CurrentUserInfo();

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeStatisticsUseCase _getHomeStatisticsUseCase;
  final GetHomeDepartmentsUseCase _getHomeDepartmentsUseCase;
  final GetHomeStatusUseCase _getHomeStatusUseCase;
  final GetCurrentUserInfoUseCase _currentUserInfoUseCase;

  HomeBloc(
    this._getHomeStatisticsUseCase,
    this._getHomeDepartmentsUseCase,
    this._getHomeStatusUseCase,
    this._currentUserInfoUseCase,
  ) : super(HomeInitial()) {
    on<GetSummariesEvent>(_onGetSummariesEvent);
  }

  final List<HomeStatistics> _statistics = [];

  FutureOr<void> _onGetSummariesEvent(
      GetSummariesEvent event, Emitter<HomeState> emit) async {
    emit(GetSummariesLoadingState());
    DataState<List<HomeStatistics>> summaries = await _getHomeStatisticsUseCase(
      skip: 0,
      pageSize: 10,
      sortColumnDirection: "desc",
      columnDirection: "descending",
    );
    // DataState<CurrentUserInfo> currentUserInfo =
    //     await _currentUserInfoUseCase();
    if (summaries is DataSuccess
        // && currentUserInfo is DataSuccess
    ) {
      _statistics.clear();
      _statistics.addAll(summaries.data ?? []);
      // currentUser = currentUserInfo.data ?? const CurrentUserInfo();
      emit(GetSummariesSuccessState(
        statistics: _statistics,
        currentUserInfo: currentUser,
      ));
      DataState<List<Department>> departments =
          await _getHomeDepartmentsUseCase();
      DataState<List<StatusModel>> status = await _getHomeStatusUseCase();
      // if (departments is DataSuccess && status is DataSuccess) {
      departmentsStore.clear();
      departmentsStore.addAll(departments.data ?? []);
      statusStore.clear();
      statusStore.addAll(status.data ?? []);
      debugPrint("departmentsStore: ${statusStore.length}");
      emit(GetSummariesSuccessState(
        statistics: _statistics,
        currentUserInfo: currentUser,
      ));
      // }
    } else if (summaries is DataFailed) {
      emit(GetSummariesErrorState(summaries.message ?? ''));
    }
  }
}
