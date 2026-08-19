part of 'strategy_details_bloc.dart';

@immutable
sealed class StrategyDetailsEvent {}

final class GetStrategyDetailsEvent extends StrategyDetailsEvent {
  final String id;
  GetStrategyDetailsEvent({required this.id});
}
