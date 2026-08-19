part of 'risks_bloc.dart';

@immutable
sealed class RisksState {}

final class RisksInitial extends RisksState {}

final class GetRisksSuccessState extends RisksState {
  final List<Risks> risks;

  GetRisksSuccessState({
    required this.risks,
  });
}

final class GetRisksErrorState extends RisksState {
  final String errorMessage;

  GetRisksErrorState({
    required this.errorMessage,
  });
}

final class GetRisksLoadingState extends RisksState {}

final class SortRisksState extends RisksState {
  final List<Risks> milstones;

  SortRisksState({required this.milstones});
}

final class GetRiskInfoLoadingState extends RisksState {}

final class GetRiskInfoSuccessState extends RisksState {
  final Risks risk;

  GetRiskInfoSuccessState({
    required this.risk,
  });
}

final class GetRiskInfoErrorState extends RisksState {
  final String errorMessage;

  GetRiskInfoErrorState({
    required this.errorMessage,
  });
}
