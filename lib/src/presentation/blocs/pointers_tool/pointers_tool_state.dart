part of 'pointers_tool_bloc.dart';

@immutable
sealed class PointersToolState {}

final class PointersToolInitial extends PointersToolState {}

final class PointersToolSuccessState extends PointersToolState {
  final List<PointersTool> pointers;

  PointersToolSuccessState({
    required this.pointers,
  });
}

final class PointersToolErrorState extends PointersToolState {
  final String errorMessage;

  PointersToolErrorState({
    required this.errorMessage,
  });
}

final class PointersToolLoadingState extends PointersToolState {}

final class SearchPointersToolState extends PointersToolState {
  final List<PointersTool> pointers;

  SearchPointersToolState({
    required this.pointers,
  });
}

final class SortPointersToolState extends PointersToolState {
  final List<PointersTool> pointers;

  SortPointersToolState({required this.pointers});
}

final class FilterPointersToolState extends PointersToolState {
  final List<PointersTool> pointers;

  FilterPointersToolState({required this.pointers});
}
