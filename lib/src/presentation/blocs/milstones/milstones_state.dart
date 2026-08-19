part of 'milstones_bloc.dart';

@immutable
sealed class MilstonesState {}

final class MilstonesInitial extends MilstonesState {}

final class GetMilstonesSuccessState extends MilstonesState {
  final List<Milstones> milstones;

  GetMilstonesSuccessState(this.milstones);
}

final class GetMilstonesErrorState extends MilstonesState {
  final String errorMessage;

  GetMilstonesErrorState(this.errorMessage);
}

final class GetMilstonesLoadingState extends MilstonesState {}

final class SearchMilstonesSuccessState extends MilstonesState {
  final List<Milstones> milstones;

  SearchMilstonesSuccessState(this.milstones);
}

final class SortMilstonesState extends MilstonesState {
  final List<Milstones> milstones;

  SortMilstonesState({required this.milstones});
}

final class FilterMilstonesState extends MilstonesState {
  final List<Milstones> milstones;

  FilterMilstonesState({required this.milstones});
}

final class GetMilstoneInfoLoadingState extends MilstonesState {}

final class GetMilstoneInfoSuccessState extends MilstonesState {
  final RemoteMilstoneDetails milstone;

  GetMilstoneInfoSuccessState(this.milstone);
}

final class GetMilstoneInfoErrorState extends MilstonesState {
  final String errorMessage;

  GetMilstoneInfoErrorState(this.errorMessage);
}

final class UpdateMilstoneLoadingState extends MilstonesState {}

final class UpdateMilstoneSuccessState extends MilstonesState {
  final String massage;

  UpdateMilstoneSuccessState({required this.massage});
}

final class UpdateMilstoneErrorState extends MilstonesState {
  final String massage;

  UpdateMilstoneErrorState({required this.massage});
}
