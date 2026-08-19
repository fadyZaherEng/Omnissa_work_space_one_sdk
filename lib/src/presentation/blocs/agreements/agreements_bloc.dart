import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/core/utils/check_filter_status.dart';
import 'package:mofa/src/core/utils/convert_string_to_date_format.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_handle_form_approval.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_task_update.dart';
import 'package:mofa/src/domain/entities/home/form_approval.dart';
import 'package:mofa/src/domain/entities/home/task_update_approval.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/domain/usecase/more/get_form_approval_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_task_update_approval_use_case.dart';
import 'package:mofa/src/domain/usecase/more/handel_task_update_approval_use_case.dart';
import 'package:mofa/src/domain/usecase/more/handle_form_approval_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/form_approval_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_agreement_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/task_update_approval_sort_use_case.dart';

part 'agreements_event.dart';

part 'agreements_state.dart';

class AgreementBloc extends Bloc<AgreementEvent, AgreementState> {
  final FormApprovalSortUseCase _formApprovalSortUseCase;
  final TaskUpdateApprovalSortUseCase _taskUpdateApprovalSortUseCase;
  final SetSortAgreementUseCase _setSortAgreementUseCase;
  final GetTaskUpdateApprovalUseCase _getTaskUpdateApprovalUseCase;
  final GetFormApprovalUseCase _getFormApprovalUseCase;
  final HandleFormApprovalUseCase _handleFormApprovalUseCase;
  final HandleTaskUpdateApprovalUseCase _handleTaskUpdateApprovalUseCase;

  AgreementBloc(
    this._setSortAgreementUseCase,
    this._formApprovalSortUseCase,
    this._taskUpdateApprovalSortUseCase,
    this._getTaskUpdateApprovalUseCase,
    this._getFormApprovalUseCase,
    this._handleFormApprovalUseCase,
    this._handleTaskUpdateApprovalUseCase,
  ) : super(AgreementInitial()) {
    on<GetCurrentAgreementsEvent>(_onGetCurrentAgreementsEvent);
    on<GetPreviousAgreementsEvent>(_onGetPreviousAgreementsEvent);
    on<SearchCurrentAgreementEvent>(_onSearchCurrentAgreementEvent);
    on<GetSortedCurrentAgreementsEvent>(_onGetSortedCurrentAgreementsEvent);
    on<FilterCurrentAgreementsEvent>(_onFilterCurrentAgreementsEvent);
    //previous
    on<SearchPreviousAgreementEvent>(_onSearchPreviousAgreementEvent);
    on<GetSortedPreviousAgreementsEvent>(_onGetSortedPreviousAgreementsEvent);
    on<FilterPreviousAgreementsEvent>(_onFilterPreviousAgreementsEvent);
    //handle
    on<HandleFormApprovalEvent>(_onHandleFormApprovalEvent);
    on<HandleTaskUpdateApproval>(_onHandleTaskUpdateApproval);
  }

  final List<FormApproval> _currentAgreements = [];
  final List<TaskUpdateApproval> _previousAgreements = [];

  // Helper to check if a field contains the search text
  bool _containsIgnoreCase(String value, String searchText) =>
      value.toLowerCase().contains(searchText);

  FutureOr<void> _onGetCurrentAgreementsEvent(
      GetCurrentAgreementsEvent event, Emitter<AgreementState> emit) async {
    if (event.isStart) {
      emit(GetCurrentAgreementsLoadingState());
    }
    final currentAgreements = await _getFormApprovalUseCase(
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
    if (currentAgreements is DataSuccess) {
      _currentAgreements.clear();
      _currentAgreements.addAll(currentAgreements.data ?? []);
      emit(GetCurrentAgreementSuccessState(agreements: _currentAgreements));
    } else {
      emit(GetCurrentAgreementErrorState(
          errorMessage: currentAgreements.message ?? ''));
    }
  }

  FutureOr<void> _onGetPreviousAgreementsEvent(
      GetPreviousAgreementsEvent event, Emitter<AgreementState> emit) async {
    if (event.isStart) {
      emit(GetPreviousAgreementsLoadingState());
    }
    final previousAgreements = await _getTaskUpdateApprovalUseCase(
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
    if (previousAgreements is DataSuccess) {
      _previousAgreements.clear();
      _previousAgreements.addAll(previousAgreements.data ?? []);
      emit(GetPreviousAgreementSuccessState(agreements: _previousAgreements));
    } else {
      emit(GetPreviousAgreementErrorState(
          errorMessage: previousAgreements.message ?? ''));
    }
  }

  FutureOr<void> _onSearchCurrentAgreementEvent(
      SearchCurrentAgreementEvent event, Emitter<AgreementState> emit) async {
    emit(GetCurrentAgreementsLoadingState());
    final searchText = event.search.trim().toLowerCase();
    if (searchText.isEmpty) {
      emit(GetCurrentAgreementSuccessState(agreements: _currentAgreements));
    } else {
      final filteredAgreements = _currentAgreements.where((agreement) {
        return _containsIgnoreCase(
                agreement.projectName.trim().toLowerCase().toString(),
                searchText) ||
            _containsIgnoreCase(
                agreement.details.info.trim().toLowerCase().toString(),
                searchText) ||
            _containsIgnoreCase(
                agreement.projectManager.toLowerCase().toString(),
                searchText) ||
            _containsIgnoreCase(
                agreement.creationDate.trim().toLowerCase().toString(),
                searchText) ||
            _containsIgnoreCase(
                agreement.id.trim().toLowerCase().toString(), searchText) ||
            _containsIgnoreCase(
                agreement.status.toString().trim().toString(), searchText);
      }).toList();

      emit(GetCurrentAgreementSuccessState(agreements: filteredAgreements));
    }
  }

  FutureOr<void> _onGetSortedCurrentAgreementsEvent(
      GetSortedCurrentAgreementsEvent event,
      Emitter<AgreementState> emit) async {
    // emit(GetCurrentAgreementsLoadingState());
    _setSortAgreementUseCase(event.sort);
    final sort = event.sort;
    // final sortedAgreements =
    //     _formApprovalSortUseCase.sortFormApproval(_currentAgreements, sort);
    // // emit(SortCurrentAgreementState(agreements: sortedAgreements));
  }

  FutureOr<void> _onFilterCurrentAgreementsEvent(
      FilterCurrentAgreementsEvent event, Emitter<AgreementState> emit) async {
    emit(GetCurrentAgreementsLoadingState());

    final Filter filter = event.filter;

    final filteredAgreements = _currentAgreements.where((agreement) {
      final matchesStatus = agreement.status == filter.statusId;
      final matchesDepartment = agreement.id == filter.departmentId.toString();
      final matchesStartDate =
          isMoreThenOrEqualDate(filter.startDate, agreement.creationDate);

      return checkFilterStatus(
        matchesStatus,
        matchesDepartment,
        matchesStartDate,
        false,
        filter,
      );
    }).toList();

    emit(FilterCurrentAgreementsState(agreements: filteredAgreements));
  }

  FutureOr<void> _onSearchPreviousAgreementEvent(
      SearchPreviousAgreementEvent event, Emitter<AgreementState> emit) async {
    emit(GetPreviousAgreementsLoadingState());
    final searchText = event.search.trim().toLowerCase();
    if (searchText.isEmpty) {
      emit(GetPreviousAgreementSuccessState(agreements: _previousAgreements));
    } else {
      final filteredAgreements = _previousAgreements.where((agreement) {
        return _containsIgnoreCase(
                agreement.projectName.trim().toLowerCase().toString(),
                searchText) ||
            _containsIgnoreCase(
                agreement.taskName.trim().toLowerCase().toString(),
                searchText) ||
            _containsIgnoreCase(
                agreement.taskStatusStr.toLowerCase().toString(), searchText) ||
            _containsIgnoreCase(
                agreement.creationDate.trim().toLowerCase().toString(),
                searchText) ||
            _containsIgnoreCase(
                agreement.id.trim().toLowerCase().toString(), searchText) ||
            _containsIgnoreCase(
                agreement.taskStatusStr.toString().trim().toString(),
                searchText);
      }).toList();

      emit(GetPreviousAgreementSuccessState(agreements: filteredAgreements));
    }
  }

  FutureOr<void> _onGetSortedPreviousAgreementsEvent(
      GetSortedPreviousAgreementsEvent event,
      Emitter<AgreementState> emit) async {
    // emit(GetPreviousAgreementsLoadingState());
    _setSortAgreementUseCase(event.sort);
    final sort = event.sort;
    final sortedAgreements = _taskUpdateApprovalSortUseCase
        .sortTaskUpdateApproval(_previousAgreements, sort);
    // emit(SortPreviousAgreementState(agreements: sortedAgreements));
  }

  FutureOr<void> _onFilterPreviousAgreementsEvent(
      FilterPreviousAgreementsEvent event, Emitter<AgreementState> emit) async {
    emit(GetPreviousAgreementsLoadingState());

    final Filter filter = event.filter;

    final filteredAgreements = _previousAgreements.where((agreement) {
      final matchesStatus = agreement.taskStatusStr
          .toLowerCase()
          .trim()
          .contains(filter.statusName.toLowerCase().trim());
      final matchesDepartment = agreement.id == filter.departmentId.toString();
      final matchesStartDate =
          isMoreThenOrEqualDate(filter.startDate, agreement.creationDate);

      return checkFilterStatus(
        matchesStatus,
        matchesDepartment,
        matchesStartDate,
        false,
        filter,
      );
    }).toList();

    emit(FilterPreviousAgreementsState(agreements: filteredAgreements));
  }

  FutureOr<void> _onHandleFormApprovalEvent(
      event, Emitter<AgreementState> emit) async {
    emit(HandleFormApprovalLoadingState());
    final response = await _handleFormApprovalUseCase(
      request: event.request,
    );
    if (response is DataSuccess) {
      emit(HandleFormApprovalSuccessState(message: response.data ?? ""));
    } else {
      emit(HandleFormApprovalErrorState(errorMessage: response.message ?? ""));
    }
  }

  FutureOr<void> _onHandleTaskUpdateApproval(
      event, Emitter<AgreementState> emit) async {
    emit(HandleTaskUpdateApprovalLoadingState());
    final response = await _handleTaskUpdateApprovalUseCase(
      request: event.request,
      actionType: event.actionType,
    );
    if (response is DataSuccess) {
      emit(HandleTaskUpdateApprovalSuccessState(
          message: response.message ?? ""));
    } else {
      emit(
        HandleTaskUpdateApprovalErrorState(
          errorMessage: response.message ?? response.data ?? "",
        ),
      );
    }
  }
}
