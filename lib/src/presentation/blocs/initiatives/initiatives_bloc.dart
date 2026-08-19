import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/core/utils/check_filter_status.dart';
import 'package:mofa/src/core/utils/convert_string_to_date_format.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/domain/usecase/more/get_initiatives_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/initiatives_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_initiatives_use_case.dart';

part 'initiatives_event.dart';

part 'initiatives_state.dart';

class InitiativesBloc extends Bloc<InitiativeEvent, InitiativesState> {
  final InitiativesSortUseCase _initiativesSortUseCase;
  final SetSortInitiativesUseCase _setSortInitiativesUseCase;
  final GetInitiativesUseCase _getInitiativesUseCase;

  InitiativesBloc(
    this._setSortInitiativesUseCase,
    this._initiativesSortUseCase,
    this._getInitiativesUseCase,
  ) : super(InitiativesInitial()) {
    on<GetInitiativesEvent>(_onGetInitiativesEvent);
    on<SearchInitiativeEvent>(_onSearchInitiativesEvent);
    on<GetSortedInitiativesEvent>(_onSortInitiativesEvent);
    on<FilterInitiativesEvent>(_onFilterInitiativesEvent);
  }

  final List<Project> _initiatives = [];

  FutureOr<void> _onGetInitiativesEvent(
      GetInitiativesEvent event, Emitter<InitiativesState> emit) async {
    if (event.isStart) {
      emit(GetInitiativesLoadingState());
    }
    DataState<List<Project>> initiatives = await _getInitiativesUseCase(
      pageSize: event.pageSize,
      skip: event.skip,
      sortColumnDirection: event.sortColumnDirection,
      columnDirection: event.columnDirection,
    );
    if (initiatives is DataSuccess) {
      _initiatives.clear();
      _initiatives.addAll(initiatives.data ?? []);
      emit(GetInitiativesSuccessState(initiatives: _initiatives));
    } else if (initiatives is DataFailed) {
      emit(GetInitiativesErrorState(errorMessage: initiatives.message ?? ""));
    }
  }

  // Helper to check if a field contains the search text
  bool _containsIgnoreCase(String value, String searchText) =>
      value.toLowerCase().contains(searchText);

  FutureOr<void> _onSearchInitiativesEvent(
      SearchInitiativeEvent event, Emitter<InitiativesState> emit) {
    emit(GetInitiativesLoadingState());
    final searchText = event.search.trim().toLowerCase();
    if (searchText.isEmpty) {
      emit(GetInitiativesSuccessState(initiatives: _initiatives));
    } else {
      final filteredInitiatives = _initiatives.where((initiative) {
        return _containsIgnoreCase(
                initiative.title.trim().toLowerCase().toString(), searchText) ||
            _containsIgnoreCase(
                initiative.managerName.trim().toLowerCase().toString(),
                searchText) ||
            _containsIgnoreCase(
                initiative.currentProjectPhaseStr
                    .trim()
                    .toLowerCase()
                    .toString(),
                searchText) ||
            _containsIgnoreCase(
                initiative.projectStartDate.trim().toLowerCase().toString(),
                searchText) ||
            _containsIgnoreCase(
                initiative.projectEndDate.trim().toLowerCase().toString(),
                searchText) ||
            _containsIgnoreCase(
                initiative.percentCompleteValue.toString().trim().toString(),
                searchText) ||
            _containsIgnoreCase(
                initiative.id.trim().toLowerCase().toString(), searchText) ||
            _containsIgnoreCase(
                initiative.projectStatusStr.toString().trim().toString(),
                searchText);
      }).toList();

      emit(GetInitiativesSuccessState(initiatives: filteredInitiatives));
    }
  }

  FutureOr<void> _onSortInitiativesEvent(
      GetSortedInitiativesEvent event, Emitter<InitiativesState> emit) {
    // emit(GetInitiativesLoadingState());
    _setSortInitiativesUseCase(event.sort);
    final sort = event.sort;
    // final sortedInitiatives =
    //     _initiativesSortUseCase.sortInitiatives(_initiatives, sort);
    // emit(SortInitiativesState(initiatives: sortedInitiatives));
  }

  FutureOr<void> _onFilterInitiativesEvent(
      FilterInitiativesEvent event, Emitter<InitiativesState> emit) {
    emit(GetInitiativesLoadingState());

    final Filter filter = event.filter;

    final filteredInitiatives = _initiatives.where((initiative) {
      final matchesStatus = initiative.projectStatusStr
          .toLowerCase()
          .trim()
          .contains(filter.statusName.toLowerCase().trim());
      final matchesDepartment = initiative.departmentName
          .toLowerCase()
          .trim()
          .contains(filter.departmentName.toLowerCase().trim());
      final matchesStartDate =
          isMoreThenOrEqualDate(filter.startDate, initiative.projectStartDate);
      final matchesEndDate =
          isLessThenDate(filter.endDate, initiative.projectEndDate);

      return checkFilterStatus(
        matchesStatus,
        matchesDepartment,
        matchesStartDate,
        matchesEndDate,
        filter,
      );
    }).toList();

    emit(FilterInitiativesState(initiatives: filteredInitiatives));
  }
}
