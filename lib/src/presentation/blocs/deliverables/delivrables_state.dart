import 'package:flutter/material.dart';
import 'package:mofa/src/domain/entities/home/deliverables.dart';

@immutable
sealed class DelivrablesState {}

final class DelivrablesInitial extends DelivrablesState {}

final class GetDelivrablesSuccessState extends DelivrablesState {
  final List<Deliverbles> delivrables;

  GetDelivrablesSuccessState(this.delivrables);
}

final class GetDelivrablesErrorState extends DelivrablesState {
  final String errorMessage;

  GetDelivrablesErrorState(this.errorMessage);
}

final class GetDelivrablesLoadingState extends DelivrablesState {}

final class SearchDelivrablesSuccessState extends DelivrablesState {
  final List<Deliverbles> delivrables;

  SearchDelivrablesSuccessState(this.delivrables);
}

final class SortDelivrablesState extends DelivrablesState {
  final List<Deliverbles> delivrables;

  SortDelivrablesState({required this.delivrables});
}

final class FilterDelivrablesState extends DelivrablesState {
  final List<Deliverbles> delivrables;

  FilterDelivrablesState({required this.delivrables});
}

final class GetDeliverableInfoSuccessState extends DelivrablesState {
  final Deliverbles deliverable;

  GetDeliverableInfoSuccessState(this.deliverable);
}

final class GetDeliverableInfoErrorState extends DelivrablesState {
  final String errorMessage;

  GetDeliverableInfoErrorState(this.errorMessage);
}

final class GetDeliverableInfoLoadingState extends DelivrablesState {}
