part of 'initiatives_bloc.dart';

@immutable
sealed class InitiativeEvent {}

class GetInitiativesEvent extends InitiativeEvent {
  final int pageSize;
  final int skip;
  final bool isStart;
  final String sortColumnDirection;
  final String columnDirection;

  GetInitiativesEvent({
    required this.pageSize,
    required this.skip,
    this.isStart = false,
    required this.sortColumnDirection,
    required this.columnDirection,
  });
}

class SearchInitiativeEvent extends InitiativeEvent {
  final String search;

  SearchInitiativeEvent({
    required this.search,
  });
}

class GetSortedInitiativesEvent extends InitiativeEvent {
  final Sort sort;

  GetSortedInitiativesEvent({
    required this.sort,
  });
}

class FilterInitiativesEvent extends InitiativeEvent {
  final Filter filter;

  FilterInitiativesEvent({required this.filter});
}
