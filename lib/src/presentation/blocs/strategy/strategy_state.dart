part of 'strategy_bloc.dart';

@immutable
sealed class StrategyState {}

final class StrategyInitial extends StrategyState {}

final class GetStrategyLoadingState extends StrategyState {}

final class GetStrategySuccessState extends StrategyState {
  final List<Strategy> strategies;

  GetStrategySuccessState({required this.strategies});
}

final class GetStrategyErrorState extends StrategyState {
  final String errorMessage;

  GetStrategyErrorState({required this.errorMessage});
}

final class SearchStrategyState extends StrategyState {
  final List<Strategy> stratgy;

  SearchStrategyState({required this.stratgy});
}

final class SortStrategyState extends StrategyState {
  final List<Strategy> stratgy;

  SortStrategyState({required this.stratgy});
}
