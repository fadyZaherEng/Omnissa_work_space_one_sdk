import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/domain/entities/home/stratgy.dart';
import 'package:mofa/src/domain/usecase/more/get_stratgy_info_use_case.dart';

part 'strategy_details_event.dart';

part 'strategy_details_state.dart';

class StrategyDetailsBloc
    extends Bloc<StrategyDetailsEvent, StrategyDetailsState> {
  final GetStratgyInfoUseCase _getStratgyInfoUseCase;

  StrategyDetailsBloc(
    this._getStratgyInfoUseCase,
  ) : super(StrategyDetailsInitial()) {
    on<GetStrategyDetailsEvent>(_onGetStrategyDetailsEvent);
  }

  FutureOr<void> _onGetStrategyDetailsEvent(
      GetStrategyDetailsEvent event, Emitter<StrategyDetailsState> emit) async {
    emit(GetStrategyDetailsLoadingState());
    DataState<Strategy> stratgyResult =
        await _getStratgyInfoUseCase(id: event.id);
    if (stratgyResult is DataSuccess) {
      emit(GetStrategyDetailsSuccessState(
          strategy: stratgyResult.data ?? const Strategy()));
    } else if (stratgyResult is DataFailed) {
      emit(GetStrategyDetailsFailedState(message: stratgyResult.message ?? ''));
    }
  }
}
