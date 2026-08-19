part of 'initiatives_bloc.dart';

@immutable
sealed class InitiativesState {}

final class InitiativesInitial extends InitiativesState {}

final class GetInitiativesLoadingState extends InitiativesState {}

final class GetInitiativesSuccessState extends InitiativesState {
  final List<Project> initiatives;

  GetInitiativesSuccessState({required this.initiatives});
}

final class GetInitiativesErrorState extends InitiativesState {
  final String errorMessage;

  GetInitiativesErrorState({required this.errorMessage});
}

final class SearchInitiativesState extends InitiativesState {
  final List<Project> initiatives;

  SearchInitiativesState({required this.initiatives});
}

final class SortInitiativesState extends InitiativesState {
  final List<Project> initiatives;

  SortInitiativesState({required this.initiatives});
}

final class FilterInitiativesState extends InitiativesState {
  final List<Project> initiatives;

  FilterInitiativesState({required this.initiatives});
}
