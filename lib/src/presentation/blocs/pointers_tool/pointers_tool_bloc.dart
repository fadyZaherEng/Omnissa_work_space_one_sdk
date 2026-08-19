import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/core/utils/check_filter_status.dart';
import 'package:mofa/src/core/utils/convert_string_to_date_format.dart';
import 'package:mofa/src/domain/entities/home/pointers_tool.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/domain/usecase/home/get_pointers_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/pointers_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_pointers_use_case.dart';

part 'pointers_tool_event.dart';

part 'pointers_tool_state.dart';

class PointersToolBloc extends Bloc<PointersToolEvent, PointersToolState> {
  final PointersSortUseCase _pointersSortUseCase;
  final SetSortPointersUseCase _setSortProjectUseCase;
  final GetHomePointersUseCase _getHomePointersUseCase;

  PointersToolBloc(
    this._setSortProjectUseCase,
    this._pointersSortUseCase,
    this._getHomePointersUseCase,
  ) : super(PointersToolInitial()) {
    on<GetPointersEvent>(_onGetPointersEvent);
    on<SearchPointersEvent>(_onSearchPointerToolEvent);
    on<GetSortedPointersToolEvent>(_onSortPointersEvent);
    on<FilterPointersToolEvent>(_onFilterPointersEvent);
  }

  final List<PointersTool> _pointers = [];

  FutureOr<void> _onGetPointersEvent(
      GetPointersEvent event, Emitter<PointersToolState> emit) async {
    if (event.isStart) {
      emit(PointersToolLoadingState());
    }
    DataState<List<PointersTool>> response = await _getHomePointersUseCase(
      pageSize: event.pageSize,
      skip: event.skip,
      sortColumnDirection: event.sortColumnDirection,
      columnDirection: event.columnDirection,
    );
    if (response is DataSuccess) {
      _pointers.clear();
      _pointers.addAll(response.data ?? []);
      emit(PointersToolSuccessState(pointers: _pointers));
    } else {
      emit(PointersToolErrorState(errorMessage: response.message ?? ""));
    }
  }

  // Helper to check if a field contains the search text
  bool _containsIgnoreCase(String value, String searchText) =>
      value.toLowerCase().contains(searchText);

  FutureOr<void> _onSearchPointerToolEvent(
      SearchPointersEvent event, Emitter<PointersToolState> emit) {
    emit(PointersToolLoadingState());
    final searchText = event.query.trim().toLowerCase();
    if (searchText.isEmpty) {
      emit(PointersToolSuccessState(pointers: _pointers));
    } else {
      final filteredPointerTools = _pointers.where((pointer) {
        return _containsIgnoreCase(
                pointer.kpiBankName.trim().toLowerCase(), searchText) ||
            _containsIgnoreCase(
                pointer.departmentName.trim().toLowerCase(), searchText) ||
            _containsIgnoreCase(
                pointer.status.trim().toLowerCase(), searchText) ||
            _containsIgnoreCase(
                pointer.creationDate.trim().toLowerCase(), searchText) ||
            _containsIgnoreCase(
                pointer.yeTarget.toString().trim().toLowerCase(), searchText) ||
            _containsIgnoreCase(pointer.id.trim().toLowerCase(), searchText) ||
            _containsIgnoreCase(
                pointer.statusColor.toString().trim().toLowerCase(),
                searchText);
      }).toList();

      emit(PointersToolSuccessState(pointers: filteredPointerTools));
    }
  }

  FutureOr<void> _onSortPointersEvent(
      GetSortedPointersToolEvent event, Emitter<PointersToolState> emit) {
    // emit(PointersToolLoadingState());
    _setSortProjectUseCase(event.sort);
    final sort = event.sort;
    // final sortedPointers = _pointersSortUseCase.sortPointers(_pointers, sort);
    // emit(SortPointersToolState(pointers: sortedPointers));
  }

  FutureOr<void> _onFilterPointersEvent(
      FilterPointersToolEvent event, Emitter<PointersToolState> emit) {
    emit(PointersToolLoadingState());

    final Filter filter = event.filter;

    final filteredPointers = _pointers.where((pointer) {
      final matchesStatus = pointer.status
          .trim()
          .toLowerCase()
          .contains(filter.statusName.trim().toLowerCase());
      final matchesDepartment = pointer.departmentName
          .trim()
          .toLowerCase()
          .contains(filter.departmentName.trim().toLowerCase());
      final matchesStartDate =
          isMoreThenOrEqualDate(filter.startDate, pointer.creationDate);

      return checkFilterStatus(
        matchesStatus,
        matchesDepartment,
        matchesStartDate,
        false,
        filter,
      );
    }).toList();

    emit(FilterPointersToolState(pointers: filteredPointers));
  }
}
