import 'package:json_annotation/json_annotation.dart';

part 'request_handle_form_approval.g.dart';

@JsonSerializable()
class RequestHandleFormApproval {
  final String? TaskId;
  final String? ActionName;
  final String? Comment;

  const RequestHandleFormApproval({
    this.TaskId,
    this.ActionName,
    this.Comment,
  });

  factory RequestHandleFormApproval.fromJson(Map<String, dynamic> json) =>
      _$RequestHandleFormApprovalFromJson(json);

  Map<String, dynamic> toJson() => _$RequestHandleFormApprovalToJson(this);
}
