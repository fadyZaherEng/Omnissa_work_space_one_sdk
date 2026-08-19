import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/stratgy.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/domain/usecase/more/get_stratgies_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_strategy_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/stratgy_sort_use_case.dart';

part 'strategy_event.dart';

part 'strategy_state.dart';

class StrategyBloc extends Bloc<StrategyEvent, StrategyState> {
  final SetSortStratgyUseCase _setSortStratgyUseCase;
  final StratgySortUseCase _stratgiesSortUseCase;
  final GetStratygiesUseCase _getStratygiesUseCase;

  StrategyBloc(
    this._setSortStratgyUseCase,
    this._stratgiesSortUseCase,
    this._getStratygiesUseCase,
  ) : super(StrategyInitial()) {
    on<GetStrategyEvent>(_onGetStrategyEvent);
    on<SearchStrategyEvent>(_onSearchStrategyEvent);
    on<GetSortedStrategyEvent>(_onGetSortedStrategyEvent);
  }

  final List<Strategy> _stratgies = [];

  FutureOr<void> _onGetStrategyEvent(
      GetStrategyEvent event, Emitter<StrategyState> emit) async {
    if (event.isStart) {
      emit(GetStrategyLoadingState());
    }
    DataState<List<Strategy>> response = await _getStratygiesUseCase(
      isMonitoringAndExecution: event.isMonitoringAndExecution,
      pageSize: event.pageSize,
      skip: event.skip,
      sortColumnDirection: event.sortColumnDirection,
      columnDirection: event.columnDirection,
    );
    if (response is DataSuccess) {
      _stratgies.clear();
      _stratgies.addAll(response.data ?? []);
      emit(GetStrategySuccessState(strategies: _stratgies));
    } else {
      emit(GetStrategyErrorState(errorMessage: response.message ?? ""));
    }
  }

  // Helper to check if a field contains the search text
  bool _containsIgnoreCase(String value, String searchText) =>
      value.toLowerCase().contains(searchText);

  FutureOr<void> _onSearchStrategyEvent(
      SearchStrategyEvent event, Emitter<StrategyState> emit) {
    emit(GetStrategyLoadingState());
    final searchText = event.search.trim().toLowerCase();
    if (searchText.isEmpty) {
      emit(GetStrategySuccessState(strategies: _stratgies));
    } else {
      final filteredStratgy = _stratgies.where((strategy) {
        return _containsIgnoreCase(
                strategy.name.trim().toLowerCase().toString(), searchText) ||
            _containsIgnoreCase(
                strategy.description.trim().toLowerCase().toString(),
                searchText) ||
            _containsIgnoreCase(
                strategy.strategyLevelName.trim().toLowerCase().toString(),
                searchText) ||
            _containsIgnoreCase(strategy.creationDate.toString(), searchText) ||
            _containsIgnoreCase(
                strategy.startDate.trim().toLowerCase().toString(),
                searchText) ||
            _containsIgnoreCase(
                strategy.endDate.trim().toLowerCase().toString(), searchText) ||
            _containsIgnoreCase(
                strategy.mission.toString().trim().toString(), searchText);
      }).toList();

      emit(GetStrategySuccessState(strategies: filteredStratgy));
    }
  }

  FutureOr<void> _onGetSortedStrategyEvent(
      GetSortedStrategyEvent event, Emitter<StrategyState> emit) {
    // emit(GetStrategyLoadingState());
    _setSortStratgyUseCase(event.sort);
    final sort = event.sort;
    // final sortedStratgy = _stratgiesSortUseCase.sortStratgy(_stratgies, sort);
    // emit(SortStrategyState(stratgy: sortedStratgy));
  }
}
