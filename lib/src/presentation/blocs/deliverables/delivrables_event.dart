import 'package:flutter/material.dart';
import 'package:mofa/src/domain/entities/shared/filter.dart';
import 'package:mofa/src/domain/entities/shared/sort.dart';

@immutable
sealed class DelivrablesEvent {}

class GetDelivrablesEvent extends DelivrablesEvent {
  final int pageSize;
  final int skip;
  final bool isStart;
  final String? departmentId;
  final int? statusId;
  final String? assignTo;
  final String searchFilterDefinition;
  final String searchValue;
  final bool isShowFilter;
  final String sortColumnDirection;
  final String columnDirection;

  GetDelivrablesEvent({
    required this.pageSize,
    required this.skip,
    this.isStart = false,
    this.departmentId,
    this.statusId,
    this.assignTo,
    this.searchFilterDefinition = "",
    this.searchValue = "",
    this.isShowFilter = false,
    required this.sortColumnDirection,
    required this.columnDirection,
  });
}

class SearchDeliverablesEvent extends DelivrablesEvent {
  final String search;

  SearchDeliverablesEvent({required this.search});
}

class GetSortedDelivrablesEvent extends DelivrablesEvent {
  final Sort sort;

  GetSortedDelivrablesEvent({
    required this.sort,
  });
}

class FilterDelivrablesEvent extends DelivrablesEvent {
  final Filter filter;

  FilterDelivrablesEvent({required this.filter});
}

class GetDeliverableInfoEvent extends DelivrablesEvent {
  final String id;

  GetDeliverableInfoEvent({required this.id});
}
