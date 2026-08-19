part of 'agreements_bloc.dart';

@immutable
sealed class AgreementEvent {}

class GetCurrentAgreementsEvent extends AgreementEvent {
  final int pageSize;
  final int skip;
  final bool isStart;
  final String? departmentId;
  final int? statusId;
  final int? priorityPriority;
  final String searchFilterDefinition;
  final String searchValue;
  final bool isShowFilter;

  final String sortColumnDirection;
  final String columnDirection;

  GetCurrentAgreementsEvent({
    required this.skip,
    required this.pageSize,
    this.isStart = false,
    this.departmentId = "",
    this.statusId = -1,
    this.priorityPriority = -1,
    this.searchFilterDefinition = "",
    this.searchValue = "",
    this.isShowFilter = false,
    required this.sortColumnDirection,
    required this.columnDirection,
  });
}

class GetPreviousAgreementsEvent extends AgreementEvent {
  final int pageSize;
  final int skip;
  final bool isStart;
  final String? departmentId;
  final int? statusId;
  final int? priorityPriority;
  final String searchFilterDefinition;
  final String searchValue;
  final bool isShowFilter;
  final String sortColumnDirection;
  final String columnDirection;

  GetPreviousAgreementsEvent({
    required this.skip,
    required this.pageSize,
    this.isStart = false,
    this.departmentId = "",
    this.statusId = -1,
    this.priorityPriority = -1,
    this.searchFilterDefinition = "",
    this.searchValue = "",
    this.isShowFilter = false,
    required this.sortColumnDirection,
    required this.columnDirection,
  });
}

class SearchCurrentAgreementEvent extends AgreementEvent {
  final String search;

  SearchCurrentAgreementEvent({
    required this.search,
  });
}

class GetSortedCurrentAgreementsEvent extends AgreementEvent {
  final Sort sort;

  GetSortedCurrentAgreementsEvent({
    required this.sort,
  });
}

class FilterCurrentAgreementsEvent extends AgreementEvent {
  final Filter filter;

  FilterCurrentAgreementsEvent({required this.filter});
}

class GetSortedPreviousAgreementsEvent extends AgreementEvent {
  final Sort sort;

  GetSortedPreviousAgreementsEvent({
    required this.sort,
  });
}

class FilterPreviousAgreementsEvent extends AgreementEvent {
  final Filter filter;

  FilterPreviousAgreementsEvent({
    required this.filter,
  });
}

class SearchPreviousAgreementEvent extends AgreementEvent {
  final String search;

  SearchPreviousAgreementEvent({
    required this.search,
  });
}

class HandleFormApprovalEvent extends AgreementEvent {
  final RequestHandleFormApproval request;

  HandleFormApprovalEvent({
    required this.request,
  });
}

class HandleTaskUpdateApproval extends AgreementEvent {
  final RequestTaskUpdate request;
  final String actionType;

  HandleTaskUpdateApproval({
    required this.request,
    required this.actionType,
  });
}
