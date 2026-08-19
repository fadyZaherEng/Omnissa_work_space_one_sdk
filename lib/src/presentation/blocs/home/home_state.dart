part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetSummariesLoadingState extends HomeState {}

final class GetSummariesSuccessState extends HomeState {
  final List<HomeStatistics> statistics;
  final CurrentUserInfo currentUserInfo;

  GetSummariesSuccessState({
    required this.statistics,
    required this.currentUserInfo,
  });
}

final class GetSummariesErrorState extends HomeState {
  final String message;

  GetSummariesErrorState(this.message);
}
