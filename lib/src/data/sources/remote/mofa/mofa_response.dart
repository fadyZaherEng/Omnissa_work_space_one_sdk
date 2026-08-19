import 'package:json_annotation/json_annotation.dart';

part 'mofa_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class MofaResponse<T> {
  @JsonKey(name: 'errorCode')
  int? statusCode;
  @JsonKey(name: 'requestId')
  String? requestId;
  @JsonKey(name: 'errorMessage')
  String? error;
  @JsonKey(name: 'check')
  bool? check;
  @JsonKey(name: 'responseMessage')
  String? responseMessage;
  @JsonKey(name: 'data')
  T? data;

  MofaResponse({
    this.statusCode,
    this.requestId,
    this.error,
    this.check,
    this.responseMessage,
    this.data,
  });

  factory MofaResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$MofaResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Function(dynamic value) value) =>
      _$MofaResponseToJson(this, (T) {
        return T;
      });
}
