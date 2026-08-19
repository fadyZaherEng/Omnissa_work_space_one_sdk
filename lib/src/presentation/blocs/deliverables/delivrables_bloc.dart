import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/core/utils/check_filter_status.dart';
import 'package:mofa/src/core/utils/convert_string_to_date_format.dart';
import 'package:mofa/src/domain/entities/home/deliverables.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/domain/usecase/more/get_deliveralbe_info_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_deliveralbes_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/deliverables_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_deliverables_use_case.dart';
import 'package:mofa/src/presentation/blocs/deliverables/delivrables_event.dart';
import 'package:mofa/src/presentation/blocs/deliverables/delivrables_state.dart';

class DelivrablesBloc extends Bloc<DelivrablesEvent, DelivrablesState> {
  final DeliverablesSortUseCase _dilevrablesSortUseCase;
  final SetSortDeliverablesUseCase _setSortDelivrablesUseCase;
  final GetDeliverablesUseCase _getDelivrablesUseCase;
  final GetDeliverableInfoUseCase _getDeliverableInfoUseCase;

  DelivrablesBloc(
    this._dilevrablesSortUseCase,
    this._setSortDelivrablesUseCase,
    this._getDelivrablesUseCase,
    this._getDeliverableInfoUseCase,
  ) : super(DelivrablesInitial()) {
    on<GetDelivrablesEvent>(_onGetDelivrablesEvent);
    on<SearchDeliverablesEvent>(_onSearchProjectEvent);
    on<FilterDelivrablesEvent>(_onFilterDeliverablesEvent);
    on<GetSortedDelivrablesEvent>(_onGetSortedDelivrablesEvent);
    on<GetDeliverableInfoEvent>(_onGetDeliverableInfoEvent);
  }
  FutureOr<void> _onGetDeliverableInfoEvent(
      GetDeliverableInfoEvent event, Emitter<DelivrablesState> emit) async {
    emit(GetDeliverableInfoLoadingState());
    DataState<Deliverbles> response =
        await _getDeliverableInfoUseCase(id: event.id);
    if (response is DataSuccess) {
      emit(GetDeliverableInfoSuccessState(response.data!));
    } else if (response is DataFailed) {
      emit(GetDeliverableInfoErrorState(response.message ?? ""));
    }
  }

  final List<Deliverbles> _dilevrables = [];

  FutureOr<void> _onGetDelivrablesEvent(
      GetDelivrablesEvent event, Emitter<DelivrablesState> emit) async {
    if (event.isStart) {
      emit(GetDelivrablesLoadingState());
    }
    DataState<List<Deliverbles>> response = await _getDelivrablesUseCase(
      skip: event.skip,
      pageSize: event.pageSize,
      departmentId: event.departmentId ?? "",
      statusId: event.statusId ?? -1,
      searchValue: event.searchValue,
      searchFilterDefinition: event.searchFilterDefinition,
      assignTo: event.assignTo ?? "",
      sortColumnDirection: event.sortColumnDirection,
      columnDirection: event.columnDirection,
    );
    if (response is DataSuccess) {
      _dilevrables.clear();
      _dilevrables.addAll(response.data ?? []);
      emit(GetDelivrablesSuccessState(_dilevrables));
    } else if (response is DataFailed) {
      emit(GetDelivrablesErrorState(response.message ?? ""));
    }
  }

  // Helper to check if a field contains the search text
  bool _containsIgnoreCase(String value, String searchText) =>
      value.toLowerCase().contains(searchText);

  FutureOr<void> _onSearchProjectEvent(
      SearchDeliverablesEvent event, Emitter<DelivrablesState> emit) {
    emit(GetDelivrablesLoadingState());
    final searchText = event.search.trim().toLowerCase();
    if (searchText.isEmpty) {
      emit(GetDelivrablesSuccessState(_dilevrables));
    } else {
      final filteredDelivrables = _dilevrables.where((delivrable) {
        return _containsIgnoreCase(
                delivrable.deliverableName.toLowerCase().trim(), searchText) ||
            _containsIgnoreCase(
                delivrable.deliverableStatusColor.label.toLowerCase().trim(),
                searchText) ||
            _containsIgnoreCase(
                delivrable.projectManagerStr.toLowerCase().trim(),
                searchText) ||
            _containsIgnoreCase(
                delivrable.projectEndDate.toLowerCase().trim(), searchText) ||
            _containsIgnoreCase(
                delivrable.projectStartDate.toLowerCase().trim(), searchText) ||
            _containsIgnoreCase(
                delivrable.projectName.toLowerCase().trim().toString(),
                searchText) ||
            _containsIgnoreCase(
                delivrable.id.toLowerCase().trim(), searchText) ||
            _containsIgnoreCase(
                delivrable.weight.toString().toLowerCase().trim(), searchText);
      }).toList();

      emit(SearchDelivrablesSuccessState(filteredDelivrables));
    }
  }

  FutureOr<void> _onGetSortedDelivrablesEvent(
      GetSortedDelivrablesEvent event, Emitter<DelivrablesState> emit) {
    // emit(GetDelivrablesLoadingState());
    _setSortDelivrablesUseCase(event.sort);
    final sort = event.sort;
    // final sortedDelivrables =
    //     _dilevrablesSortUseCase.sortDeliverables(_dilevrables, sort);
    // emit(SortDelivrablesState(delivrables: sortedDelivrables));
  }

  FutureOr<void> _onFilterDeliverablesEvent(
      FilterDelivrablesEvent event, Emitter<DelivrablesState> emit) {
    emit(GetDelivrablesLoadingState());

    final Filter filter = event.filter;

    final filteredDeliverables = _dilevrables.where((delivrable) {
      final matchesStatus = delivrable.deliverableStatusColor.label
          .toLowerCase()
          .trim()
          .contains(filter.statusName.toLowerCase().trim());
      final matchesDepartment = delivrable.deliverableName
          .toLowerCase()
          .trim()
          .contains(filter.departmentName.toLowerCase().trim());
      final matchesStartDate =
          isMoreThenOrEqualDate(filter.startDate, delivrable.projectStartDate);
      final matchesEndDate =
          isLessThenDate(filter.endDate, delivrable.projectEndDate);

      return checkFilterStatus(
        matchesStatus,
        matchesDepartment,
        matchesStartDate,
        matchesEndDate,
        filter,
      );
    }).toList();

    emit(FilterDelivrablesState(delivrables: filteredDeliverables));
  }
}
