part of 'risks_bloc.dart';

@immutable
sealed class RisksEvent {}

class GetRisksEvent extends RisksEvent {
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

  GetRisksEvent({
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

class GetRisksInfoEvent extends RisksEvent {
  final String id;

  GetRisksInfoEvent({
    required this.id,
  });
}

class GetSortedRiskEvent extends RisksEvent {
  final Sort sort;

  GetSortedRiskEvent({
    required this.sort,
  });
}
