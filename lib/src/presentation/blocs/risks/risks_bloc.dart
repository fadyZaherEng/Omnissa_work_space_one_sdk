import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/risks.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';
import 'package:mofa/src/domain/usecase/more/get_risks_info_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_risks_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/riskss_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_risks_use_case.dart';

part 'risks_event.dart';

part 'risks_state.dart';

class RisksBloc extends Bloc<RisksEvent, RisksState> {
  final GetRisksUseCase _getRisksUseCase;
  final RisksSortUseCase _risksSortUseCase;
  final SetSortRisksUseCase _setSortRisksUseCase;
  final GetRisksInfoUseCase _getRisksInfoUseCase;

  RisksBloc(
    this._getRisksUseCase,
    this._setSortRisksUseCase,
    this._risksSortUseCase,
    this._getRisksInfoUseCase,
  ) : super(RisksInitial()) {
    on<GetRisksEvent>(_onGetRisksEvent);
    on<GetSortedRiskEvent>(_onGetSortedRisksEvent);
    on<GetRisksInfoEvent>(_onGetRisksInfoEvent);
  }

  FutureOr<void> _onGetRisksInfoEvent(
      GetRisksInfoEvent event, Emitter<RisksState> emit) async {
    emit(GetRiskInfoLoadingState());
    final risks = await _getRisksInfoUseCase(id: event.id);
    if (risks is DataSuccess) {
      emit(GetRiskInfoSuccessState(risk: risks.data!));
    } else if (risks is DataFailed) {
      emit(GetRiskInfoErrorState(errorMessage: risks.message ?? ""));
    }
  }

  final List<Risks> _risks = [];

  FutureOr<void> _onGetRisksEvent(
      GetRisksEvent event, Emitter<RisksState> emit) async {
    if (event.isStart) {
      emit(GetRisksLoadingState());
    }
    final risks = await _getRisksUseCase(
      pageSize: event.pageSize,
      skip: event.skip,
      searchFilterDefinition: event.searchFilterDefinition,
      searchValue: event.searchValue,
      departmentId: event.departmentId == null ? "" : event.departmentId!,
      priorityId: event.priorityPriority == null ? -1 : event.priorityPriority!,
      statusId: event.statusId == null ? -1 : event.statusId!,
      sortColumnDirection: event.sortColumnDirection,
      columnDirection: event.columnDirection,
    );
    if (risks is DataSuccess) {
      _risks.clear();
      _risks.addAll(risks.data ?? []);
      emit(GetRisksSuccessState(risks: _risks));
    } else if (risks is DataFailed) {
      emit(GetRisksErrorState(errorMessage: risks.message ?? ""));
    }
  }

  FutureOr<void> _onGetSortedRisksEvent(
      GetSortedRiskEvent event, Emitter<RisksState> emit) {
    // emit(GetRisksLoadingState());
    _setSortRisksUseCase(event.sort);
    // final sort = event.sort;
    // final sortedRisk = _risksSortUseCase.sortRisks(_risks, sort);
    // emit(SortRisksState(milstones: sortedRisk));
  }
}
