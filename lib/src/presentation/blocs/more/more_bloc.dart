import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mofa/src/domain/usecase/more/get_challenges_info_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_challenges_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_risks_info_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_risks_use_case.dart';

part 'more_event.dart';

part 'more_state.dart';

class MoreBloc extends Bloc<MoreEvent, MoreState> {
  final GetChallengesUseCase _getChallengesUseCase;
  final GetChallengesInfoUseCase _getChallengesInfoUseCase;
  final GetRisksInfoUseCase _getRisksInfoUseCase;
  final GetRisksUseCase _getRisksUseCase;

  MoreBloc(
    this._getChallengesUseCase,
    this._getChallengesInfoUseCase,
    this._getRisksInfoUseCase,
    this._getRisksUseCase,
  ) : super(MoreInitial()) {
    on<MoreEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
