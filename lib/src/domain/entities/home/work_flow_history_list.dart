import 'package:equatable/equatable.dart';

class WorkFlowHistoryList extends Equatable {
  final String stage;
  final String actionEn;
  final String action;
  final String comments;
  final String projectManagerEmail;
  final String projectManagerName;
  final String nickName;
  final String departmentName;
  final String otherDetails;
  final String createdBy;
  final String createdByName;
  final String creationDateStr;
  final String creationDate;

  const WorkFlowHistoryList({
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

  @override
  List<Object?> get props => [
        stage,
        actionEn,
        action,
        comments,
        projectManagerEmail,
        projectManagerName,
        nickName,
        departmentName,
        otherDetails,
        createdBy,
        createdByName,
        creationDateStr,
        creationDate,
      ];
}

class TimelineItem {
  final String time;
  final String oldStatus;
  final String newStatusEn;
  final String newStatusAr;
  final String createdBy;
  final String phaseIcon;
  final String departmentName;
  final String projectManagerName;

  TimelineItem({
    required this.time,
    required this.oldStatus,
    required this.newStatusEn,
    required this.newStatusAr,
    required this.departmentName,
    required this.createdBy,
    required this.phaseIcon,
    required this.projectManagerName,
  });

  factory TimelineItem.fromWorkFlowHistory(WorkFlowHistoryList item) {
    return TimelineItem(
      time: item.creationDate,
      oldStatus: item.stage,
      newStatusAr: item.action,
      newStatusEn: item.actionEn,
      departmentName: item.departmentName,
      createdBy: item.createdByName,
      phaseIcon: item.actionEn,
      projectManagerName: item.projectManagerName,
    );
  }
}
