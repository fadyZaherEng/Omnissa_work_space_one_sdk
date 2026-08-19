import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/domain/entities/home/work_flow_history_list.dart';

part 'remote_work_flow_history_list.g.dart';

@JsonSerializable()
class RemoteWorkFlowHistoryList {
  final String? stage;
  final String? actionEn;
  final String? action;
  final String? comments;
  final String? projectManagerEmail;
  final String? projectManagerName;
  final String? nickName;
  final String? departmentName;
  final String? otherDetails;
  final String? createdBy;
  final String? createdByName;
  final String? creationDateStr;
  final String? creationDate;

  const RemoteWorkFlowHistoryList({
    this.stage = '',
    this.actionEn = '',
    this.action = '',
    this.comments = '',
    this.projectManagerEmail = '',
    this.projectManagerName = '',
    this.nickName = '',
    this.departmentName = '',
    this.otherDetails = '',
    this.createdBy = '',
    this.createdByName = '',
    this.creationDateStr = '',
    this.creationDate = '',
  });

  factory RemoteWorkFlowHistoryList.fromJson(Map<String, dynamic> json) =>
      _$RemoteWorkFlowHistoryListFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteWorkFlowHistoryListToJson(this);
}

extension RemoteWorkFlowHistoryExtension on RemoteWorkFlowHistoryList {
  WorkFlowHistoryList mapToDomain() {
    return WorkFlowHistoryList(
      stage: stage ?? '',
      actionEn: actionEn ?? '',
      action: action ?? '',
      comments: comments ?? '',
      projectManagerEmail: projectManagerEmail ?? '',
      projectManagerName: projectManagerName ?? '',
      nickName: nickName ?? '',
      departmentName: departmentName ?? '',
      otherDetails: otherDetails ?? '',
      createdBy: createdBy ?? '',
      createdByName: createdByName ?? '',
      creationDateStr: creationDateStr ?? '',
      creationDate: creationDate ?? '',
    );
  }
}

extension WorkFlowHistoryListExtension on List<RemoteWorkFlowHistoryList> {
  List<WorkFlowHistoryList> mapToDomain() {
    return map((e) => e.mapToDomain()).toList();
  }
}
