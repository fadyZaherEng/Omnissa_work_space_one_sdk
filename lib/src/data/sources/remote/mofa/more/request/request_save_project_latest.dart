import 'package:json_annotation/json_annotation.dart';

part 'request_save_project_latest.g.dart';

@JsonSerializable()
class RequestSaveProjectLatest {
  final String? id;
  final String? latestUpdateBrief;

  const RequestSaveProjectLatest({
    this.id,
    this.latestUpdateBrief,
  });

  factory RequestSaveProjectLatest.fromJson(Map<String, dynamic> json) =>
      _$RequestSaveProjectLatestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestSaveProjectLatestToJson(this);
}
