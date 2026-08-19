part of 'strategy_details_bloc.dart';

@immutable
sealed class StrategyDetailsState {}

final class StrategyDetailsInitial extends StrategyDetailsState {}

final class GetStrategyDetailsLoadingState extends StrategyDetailsState {}

final class GetStrategyDetailsSuccessState extends StrategyDetailsState {
  final Strategy strategy;

  GetStrategyDetailsSuccessState({required this.strategy});
}

final class GetStrategyDetailsFailedState extends StrategyDetailsState {
  final String message;

  GetStrategyDetailsFailedState({required this.message});
}
