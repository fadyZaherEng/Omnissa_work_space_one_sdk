part of 'strategy_bloc.dart';

@immutable
sealed class StrategyEvent {}

class GetStrategyEvent extends StrategyEvent {
  final bool isMonitoringAndExecution;
  final int pageSize;
  final int skip;
  final bool isStart;

  final String sortColumnDirection;
  final String columnDirection;

  GetStrategyEvent({
    required this.isMonitoringAndExecution,
    required this.pageSize,
    required this.skip,
    this.isStart = false,
    required this.sortColumnDirection,
    required this.columnDirection,
  });
}

class SearchStrategyEvent extends StrategyEvent {
  final String search;

  SearchStrategyEvent({
    required this.search,
  });
}

class GetSortedStrategyEvent extends StrategyEvent {
  final Sort sort;

  GetSortedStrategyEvent({
    required this.sort,
  });
}
