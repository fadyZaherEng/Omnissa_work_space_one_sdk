import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/core/utils/check_filter_status.dart';
import 'package:mofa/src/core/utils/convert_string_to_date_format.dart';
import 'package:mofa/src/domain/entities/home/challenges.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/domain/usecase/more/get_challenges_info_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_challenges_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/challenges_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_challenges_use_case.dart';

part 'challenges_event.dart';

part 'challenges_state.dart';

class ChallengesBloc extends Bloc<ChallengesEvent, ChallengesState> {
  final SetSortChallengesUseCase _setSortChallengesUseCase;
  final ChallengesSortUseCase _challengesSortUseCase;
  final GetChallengesUseCase _getChallengesUseCase;
  final GetChallengesInfoUseCase _getChallengesInfoUseCase;

  ChallengesBloc(
    this._setSortChallengesUseCase,
    this._challengesSortUseCase,
    this._getChallengesUseCase,
    this._getChallengesInfoUseCase,
  ) : super(ChallengesInitial()) {
    on<GetChallengesEvent>(_onGetRisksEvent);
    on<SearchChallengesEvent>(_onSearchChallengesEvent);
    on<GetSortedChallengesEvent>(_onGetSortedChallengesEvent);
    on<FilterChallengesEvent>(_onFilterChallengesEvent);
    on<GetChallengesInfoEvent>(_onGetChallengesInfoEvent);
  }

  FutureOr<void> _onGetChallengesInfoEvent(
      GetChallengesInfoEvent event, Emitter<ChallengesState> emit) async {
    emit(GetChallengesInfoLoadingState());
    final result = await _getChallengesInfoUseCase(id: event.id);
    if (result is DataSuccess) {
      emit(GetChallengesInfoSuccessState(challenge: result.data!));
    } else if (result is DataFailed) {
      emit(GetChallengesInfoErrorState(message: result.message ?? ''));
    }
  }

  final List<Challenges> _challenges = [];

  FutureOr<void> _onGetRisksEvent(
      GetChallengesEvent event, Emitter<ChallengesState> emit) async {
    if (event.isStart) {
      emit(GetChallengesLoadingState());
    }
    final result = await _getChallengesUseCase(
      skip: event.skip,
      pageSize: event.pageSize,
      departmentId: event.departmentId ?? "",
      statusId: event.statusId ?? -1,
      priorityId: event.priorityPriority ?? -1,
      searchFilterDefinition: event.searchFilterDefinition,
      searchValue: event.searchValue,
      sortColumnDirection: event.sortColumnDirection,
      columnDirection: event.columnDirection,
    );
    if (result is DataSuccess) {
      _challenges.clear();
      _challenges.addAll(result.data ?? []);

      emit(GetChallengesSuccessState(challenges: _challenges));
    } else if (result is DataFailed) {
      emit(GetChallengesErrorState(message: result.message ?? ''));
    }
  }

  // Helper to check if a field contains the search text
  bool _containsIgnoreCase(String value, String searchText) =>
      value.toLowerCase().contains(searchText);

  FutureOr<void> _onSearchChallengesEvent(
      SearchChallengesEvent event, Emitter<ChallengesState> emit) {
    emit(GetChallengesLoadingState());

    final searchText = event.search.trim().toLowerCase();
    if (searchText.isEmpty) {
      emit(GetChallengesSuccessState(challenges: _challenges));
    } else {
      bool matchesSearch(String? value) {
        return _containsIgnoreCase(
            value?.trim().toLowerCase() ?? '', searchText);
      }

      final filteredChallenges = _challenges.where((challenge) {
        return matchesSearch(challenge.title) ||
            matchesSearch(challenge.projectManagerStr) ||
            matchesSearch(challenge.department) ||
            matchesSearch(challenge.status) ||
            matchesSearch(challenge.solveDate) ||
            matchesSearch(challenge.endDate) ||
            matchesSearch(challenge.challengeRisk.percentage.toString()) ||
            matchesSearch(challenge.id) ||
            matchesSearch(challenge.challengeRisk.name) ||
            matchesSearch(challenge.category) ||
            matchesSearch(challenge.severityOfTheChallenge.name) ||
            matchesSearch(challenge.severityOfTheChallenge.color.toString()) ||
            matchesSearch(challenge.address) ||
            matchesSearch(challenge.suggestSolution) ||
            matchesSearch(challenge.description) ||
            matchesSearch(challenge.problemChallenge) ||
            matchesSearch(challenge.workflowCases.name) ||
            matchesSearch(challenge.workflowCases.percentage.toString()) ||
            matchesSearch(challenge.statusColor.toString());
      }).toList();

      emit(GetChallengesSuccessState(challenges: filteredChallenges));
    }
  }

  FutureOr<void> _onGetSortedChallengesEvent(
      GetSortedChallengesEvent event, Emitter<ChallengesState> emit) {
    // emit(GetChallengesLoadingState());
    _setSortChallengesUseCase(event.sort);
    final sort = event.sort;
    // final sortedChallenges =
    //     _challengesSortUseCase.sortChallenges(_challenges, sort);
    // emit(SortChallengesState(challenges: sortedChallenges));
  }

  FutureOr<void> _onFilterChallengesEvent(
      FilterChallengesEvent event, Emitter<ChallengesState> emit) {
    emit(GetChallengesLoadingState());

    final Filter filter = event.filter;

    final filteredChallenges = _challenges.where((challenge) {
      final matchesStatus = challenge.statusStr
          .toLowerCase()
          .trim()
          .contains(filter.statusName.toLowerCase().trim());
      final matchesDepartment = challenge.department
          .toLowerCase()
          .trim()
          .contains(filter.departmentName.toLowerCase().trim());
      final matchesStartDate =
          isMoreThenOrEqualDate(filter.startDate, challenge.solveDate);
      final matchesEndDate = isLessThenDate(filter.endDate, challenge.endDate);

      return checkFilterStatus(
        matchesStatus,
        matchesDepartment,
        matchesStartDate,
        matchesEndDate,
        filter,
      );
    }).toList();

    emit(FilterChallengesState(challenges: filteredChallenges));
  }
}
