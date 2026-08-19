import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';

class Task extends Equatable {
  final String id;
  final String name;
  final ProjectModel project;
  final String taskOwnerStr;
  final String taskStatusStr;
  final String taskPriorityStr;
  final String taskStartDate;
  final String taskEndDate;
  final int duration;
  final int percentDone;
  final String baselineStartDate;
  final String baselineEndDate;
  final int weight;
  final String assignmentId;
  final int draftPercentDone;
  final int draftPriority;
  final int draftStatus;
  final String wfStatus;
  final Color statusColor;
  final int numberOfDays;
  final Status achievement;
  final bool isOperationalTask;
  final String requestedDepartmentStr;
  final String assignedDepartmentStr;
  final WFStatusColor wfStatusColor;
  final WFStatusColor draftStatusObject;
  final String comment;

  const Task({
    this.id = '',
    this.statusColor = Colors.transparent,
    this.numberOfDays = 0,
    this.taskStartDate = '',
    this.taskEndDate = '',
    this.achievement = const Status(),
    this.name = '',
    this.project = const ProjectModel(),
    this.taskOwnerStr = '',
    this.duration = 0,
    this.percentDone = 0,
    this.baselineStartDate = '',
    this.baselineEndDate = '',
    this.weight = 0,
    this.assignmentId = '',
    this.draftPercentDone = 0,
    this.draftPriority = 0,
    this.draftStatus = 0,
    this.wfStatus = '',
    this.isOperationalTask = false,
    this.requestedDepartmentStr = '',
    this.assignedDepartmentStr = '',
    this.wfStatusColor = const WFStatusColor(),
    this.draftStatusObject = const WFStatusColor(),
    this.comment = '',
    this.taskStatusStr = '',
    this.taskPriorityStr = '',
  });

  @override
  List<Object?> get props => [
        id,
        statusColor,
        numberOfDays,
        taskStartDate,
        taskEndDate,
        achievement,
        name,
        project,
        taskOwnerStr,
        duration,
        percentDone,
        baselineStartDate,
        baselineEndDate,
        weight,
        assignmentId,
        draftPercentDone,
        draftPriority,
        draftStatus,
        wfStatus,
        isOperationalTask,
        requestedDepartmentStr,
        assignedDepartmentStr,
        wfStatusColor,
        draftStatusObject,
        comment,
        taskStatusStr,
        taskPriorityStr,
      ];
}

class WFStatusColor {
  final String color;
  final String label;

  const WFStatusColor({
    this.color = '',
    this.label = '',
  });
}

class ProjectModel extends Equatable {
  final String projectName;
  final String projectManagerName;

  const ProjectModel({
    this.projectName = '',
    this.projectManagerName = '',
  });

  @override
  List<Object?> get props => [
        projectName,
        projectManagerName,
      ];
}
