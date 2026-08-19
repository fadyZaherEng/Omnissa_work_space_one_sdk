part of 'milstones_bloc.dart';

@immutable
sealed class MilstonesEvent {}

class GetMilstonesEvent extends MilstonesEvent {
  final int pageSize;
  final int skip;
  final bool isStart;
  final String sortColumnDirection;
  final String columnDirection;

  GetMilstonesEvent({
    required this.pageSize,
    required this.skip,
    this.isStart = false,
    required this.sortColumnDirection,
    required this.columnDirection,
  });
}

class SearchMilstonesEvent extends MilstonesEvent {
  final String search;

  SearchMilstonesEvent({required this.search});
}

class GetSortedMilstonesEvent extends MilstonesEvent {
  final Sort sort;

  GetSortedMilstonesEvent({
    required this.sort,
  });
}

class FilterMilstonesEvent extends MilstonesEvent {
  final Filter filter;

  FilterMilstonesEvent({required this.filter});
}

class GetMilstoneInfoEvent extends MilstonesEvent {
  final String id;
  final int pageSize;
  final int skip;
  final String sortColumnDirection;

  final String columnDirection;

  GetMilstoneInfoEvent({
    required this.id,
    required this.pageSize,
    required this.skip,
    required this.sortColumnDirection,
    required this.columnDirection,
  });
}

class UpdateMilstoneEvent extends MilstonesEvent {
  final RequestUpdateMilstone requestUpdateMilstone;

  UpdateMilstoneEvent({required this.requestUpdateMilstone});
}
