part of 'challenges_bloc.dart';

@immutable
sealed class ChallengesState {}

final class ChallengesInitial extends ChallengesState {}

final class GetChallengesSuccessState extends ChallengesState {
  final List<Challenges> challenges;

  GetChallengesSuccessState({
    required this.challenges,
  });
}

final class GetChallengesErrorState extends ChallengesState {
  final String message;

  GetChallengesErrorState({
    required this.message,
  });
}

final class GetChallengesLoadingState extends ChallengesState {}

final class SearchChallengesState extends ChallengesState {
  final List<Challenges> challenges;

  SearchChallengesState({required this.challenges});
}

final class SortChallengesState extends ChallengesState {
  final List<Challenges> challenges;

  SortChallengesState({required this.challenges});
}

final class FilterChallengesState extends ChallengesState {
  final List<Challenges> challenges;

  FilterChallengesState({required this.challenges});
}

final class GetChallengesInfoLoadingState extends ChallengesState {}

final class GetChallengesInfoSuccessState extends ChallengesState {
  final Challenges challenge;

  GetChallengesInfoSuccessState({
    required this.challenge,
  });
}

final class GetChallengesInfoErrorState extends ChallengesState {
  final String message;

  GetChallengesInfoErrorState({
    required this.message,
  });
}
