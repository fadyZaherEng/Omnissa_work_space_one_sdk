part of 'agreements_bloc.dart';

@immutable
sealed class AgreementState {}

final class AgreementInitial extends AgreementState {}

final class GetCurrentAgreementsLoadingState extends AgreementState {}

final class GetCurrentAgreementSuccessState extends AgreementState {
  final List<FormApproval> agreements;

  GetCurrentAgreementSuccessState({required this.agreements});
}

final class GetCurrentAgreementErrorState extends AgreementState {
  final String errorMessage;

  GetCurrentAgreementErrorState({required this.errorMessage});
}

final class GetPreviousAgreementsLoadingState extends AgreementState {}

final class GetPreviousAgreementSuccessState extends AgreementState {
  final List<TaskUpdateApproval> agreements;

  GetPreviousAgreementSuccessState({required this.agreements});
}

final class GetPreviousAgreementErrorState extends AgreementState {
  final String errorMessage;

  GetPreviousAgreementErrorState({required this.errorMessage});
}

final class SearchCurrentAgreementState extends AgreementState {
  final List<FormApproval> agreements;

  SearchCurrentAgreementState({required this.agreements});
}

final class SortCurrentAgreementState extends AgreementState {
  final List<FormApproval> agreements;

  SortCurrentAgreementState({required this.agreements});
}

final class FilterCurrentAgreementsState extends AgreementState {
  final List<FormApproval> agreements;

  FilterCurrentAgreementsState({required this.agreements});
}

final class SearchPreviousAgreementState extends AgreementState {
  final List<TaskUpdateApproval> agreements;

  SearchPreviousAgreementState({required this.agreements});
}

final class SortPreviousAgreementState extends AgreementState {
  final List<TaskUpdateApproval> agreements;

  SortPreviousAgreementState({required this.agreements});
}

final class FilterPreviousAgreementsState extends AgreementState {
  final List<TaskUpdateApproval> agreements;

  FilterPreviousAgreementsState({required this.agreements});
}

final class HandleFormApprovalLoadingState extends AgreementState {}

final class HandleFormApprovalSuccessState extends AgreementState {
  final String message;

  HandleFormApprovalSuccessState({required this.message});
}

final class HandleFormApprovalErrorState extends AgreementState {
  final String errorMessage;

  HandleFormApprovalErrorState({required this.errorMessage});
}

final class HandleTaskUpdateApprovalLoadingState extends AgreementState {}

final class HandleTaskUpdateApprovalSuccessState extends AgreementState {
  final String message;

  HandleTaskUpdateApprovalSuccessState({required this.message});
}

final class HandleTaskUpdateApprovalErrorState extends AgreementState {
  final String errorMessage;

  HandleTaskUpdateApprovalErrorState({required this.errorMessage});
}
