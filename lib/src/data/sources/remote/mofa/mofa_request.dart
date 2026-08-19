import 'package:json_annotation/json_annotation.dart';

part 'mofa_request.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class MofaRequest<T> {
  @JsonKey(name: 'draw')
  String? draw;
  @JsonKey(name: 'start')
  String? start;
  @JsonKey(name: 'length')
  String? length;
  @JsonKey(name: 'orderColumn')
  String? orderColumn;
  @JsonKey(name: 'sortColumn')
  String? sortColumn;
  @JsonKey(name: 'sortColumnDirection')
  String? sortColumnDirection;
  @JsonKey(name: 'columnDirection')
  String? columnDirection;
  @JsonKey(name: 'pageSize')
  int? pageSize;
  @JsonKey(name: 'skip')
  int? skip;
  @JsonKey(name: 'searchValue')
  String? searchValue;
  @JsonKey(name: 'searchFilterDefinition')
  String? searchFilterDefinition;
  @JsonKey(name: 'data')
  T? data;

  MofaRequest({
    this.draw,
    this.start,
    this.length,
    this.orderColumn,
    this.sortColumn,
    this.sortColumnDirection,
    this.columnDirection,
    this.pageSize,
    this.skip,
    this.searchValue,
    this.searchFilterDefinition,
    this.data,
  });

  factory MofaRequest.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$MofaRequestFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Function(dynamic value) value) =>
      _$MofaRequestToJson(this, (T) {
        return T;
      });

  MofaRequest<T> createRequest({
    T,
    required int pageSize,
    required int skip,
    required String searchValue,
    required String searchFilterDefinition,
    required String sortColumnDirection,
    required String columnDirection,
    String draw = "1",
  }) {
    return MofaRequest(
      draw: draw,
      start: "0",
      length: "10",
      orderColumn: "0",
      sortColumn: "CreationDate",
      sortColumnDirection: sortColumnDirection,
      // "desc",
      columnDirection: columnDirection,
      // "descending",
      pageSize: pageSize,
      skip: skip,
      searchValue: searchValue,
      searchFilterDefinition: searchFilterDefinition,
      data: T,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'draw': draw,
      'start': start,
      'length': length,
      'orderColumn': orderColumn,
      'sortColumn': sortColumn,
      'sortColumnDirection': sortColumnDirection,
      'columnDirection': columnDirection,
      'pageSize': pageSize,
      'skip': skip,
      'searchValue': searchValue,
      'searchFilterDefinition': searchFilterDefinition,
      'data': data,
    };
  }

  factory MofaRequest.fromMap(Map<String, dynamic> map) {
    return MofaRequest(
      draw: map['draw'] as String,
      start: map['start'] as String,
      length: map['length'] as String,
      orderColumn: map['orderColumn'] as String,
      sortColumn: map['sortColumn'] as String,
      sortColumnDirection: map['sortColumnDirection'] as String,
      columnDirection: map['columnDirection'] as String,
      pageSize: map['pageSize'] as int,
      skip: map['skip'] as int,
      searchValue: map['searchValue'] as String,
      searchFilterDefinition: map['searchFilterDefinition'] as String,
      data: map['data'] as T,
    );
  }

  MofaRequest<T> copyWith({
    int? userId,
    int? subscriberId,
    int? userTypeId,
    int? unitId,
    int? compoundId,
    String? languageCode,
  }) {
    return MofaRequest(
      draw: draw,
      start: start,
      length: length,
      orderColumn: orderColumn,
      sortColumn: sortColumn,
      sortColumnDirection: sortColumnDirection,
      columnDirection: columnDirection,
      pageSize: pageSize,
      skip: skip,
      searchValue: searchValue,
      searchFilterDefinition: searchFilterDefinition,
      data: data,
    );
  }
}
