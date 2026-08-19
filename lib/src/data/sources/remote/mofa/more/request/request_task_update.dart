import 'package:json_annotation/json_annotation.dart';

part 'request_task_update.g.dart';

@JsonSerializable()
class RequestTaskUpdate {
  final String? wfTaskId;
  final String? recordId;
  final String? taskId;
  final String? comment;
  final bool? isApproved;

  const RequestTaskUpdate({
    this.wfTaskId,
    this.recordId,
    this.taskId,
    this.comment,
    this.isApproved,
  });

  factory RequestTaskUpdate.fromJson(Map<String, dynamic> json) =>
      _$RequestTaskUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$RequestTaskUpdateToJson(this);
}
