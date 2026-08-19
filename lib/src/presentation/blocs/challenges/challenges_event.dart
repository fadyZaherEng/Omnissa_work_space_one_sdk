part of 'challenges_bloc.dart';

@immutable
sealed class ChallengesEvent {}

class GetChallengesEvent extends ChallengesEvent {
  final int pageSize;
  final int skip;
  final bool isStart;
  final String? departmentId;
  final int? statusId;
  final int? priorityPriority;
  final String searchFilterDefinition;
  final String searchValue;
  final bool isShowFilter;
  final String sortColumnDirection;
  final String columnDirection;

  GetChallengesEvent({
    required this.pageSize,
    required this.skip,
    this.isStart = false,
    this.departmentId,
    this.statusId,
    this.priorityPriority,
    this.searchFilterDefinition = "",
    this.searchValue = "",
    this.isShowFilter = false,
    required this.sortColumnDirection,
    required this.columnDirection,
  });
}

class GetChallengesInfoEvent extends ChallengesEvent {
  final String id;

  GetChallengesInfoEvent({
    required this.id,
  });
}

class SearchChallengesEvent extends ChallengesEvent {
  final String search;

  SearchChallengesEvent({
    required this.search,
  });
}

class GetSortedChallengesEvent extends ChallengesEvent {
  final Sort sort;

  GetSortedChallengesEvent({
    required this.sort,
  });
}

class FilterChallengesEvent extends ChallengesEvent {
  final Filter filter;

  FilterChallengesEvent({required this.filter});
}
