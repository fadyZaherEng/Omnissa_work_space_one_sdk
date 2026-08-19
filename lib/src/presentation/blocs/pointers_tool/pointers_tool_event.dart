part of 'pointers_tool_bloc.dart';

@immutable
sealed class PointersToolEvent {}

class GetPointersEvent extends PointersToolEvent {
  final int pageSize;
  final int skip;
  final bool isStart;

  final String sortColumnDirection;
  final String columnDirection;

  GetPointersEvent({
    required this.pageSize,
    required this.skip,
    this.isStart = false,
    required this.sortColumnDirection,
    required this.columnDirection,
  });
}

class SearchPointersEvent extends PointersToolEvent {
  final String query;

  SearchPointersEvent(this.query);
}

class GetSortedPointersToolEvent extends PointersToolEvent {
  final Sort sort;

  GetSortedPointersToolEvent({
    required this.sort,
  });
}

class FilterPointersToolEvent extends PointersToolEvent {
  final Filter filter;

  FilterPointersToolEvent({required this.filter});
}
