import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';

class Assignments {
  final String resourceName;
  final String id;
  final String taskId;
  final String resourceId;
  final int units;
  final List<AssignmentHistory> assignmentHistory;

  const Assignments({
    this.resourceName = '',
    this.id = '',
    this.taskId = '',
    this.resourceId = '',
    this.units = 0,
    this.assignmentHistory = const [],
  });
}

class AssignmentHistory {
  final String date;
  final int units;

  const AssignmentHistory({
    this.date = '',
    this.units = 0,
  });
}

class Landmark extends Equatable {
  final String name;
  final String note;
  final String id;
  final String managerName;
  final String address;
  final String implementationState;
  final String endDateExpected;
  final String startDateBasicsLine;
  final String endDateBasicsLine;
  final String endDateReal;
  final Status progressImplementation;
  final String status;
  final Color statusColor;
  final int numberOfDays;
  final int weight;
  final String startDate;
  final String endDate;
  final int duration;
  final int percentDone;
  final String creationDate;
  final int projectCardStatus;
  final ProjectStatusColor projectStatusColor;
  final List<Assignments> assignments;

  const Landmark({
    this.name = '',
    this.id = '',
    this.managerName = '',
    this.address = '',
    this.endDateExpected = '',
    this.endDateReal = '',
    this.progressImplementation = const Status(),
    this.status = '',
    this.statusColor = Colors.transparent,
    this.implementationState = '',
    this.startDateBasicsLine = '',
    this.numberOfDays = 0,
    this.weight = 0,
    this.endDateBasicsLine = '',
    this.startDate = '',
    this.endDate = '',
    this.duration = 0,
    this.percentDone = 0,
    this.creationDate = '',
    this.projectCardStatus = 0,
    this.projectStatusColor = const ProjectStatusColor(),
    this.assignments = const [],
    this.note = '',
  });

  @override
  List<Object?> get props => [
        name,
        id,
        managerName,
        status,
        statusColor,
        address,
        endDateExpected,
        endDateReal,
        progressImplementation,
        implementationState,
        startDateBasicsLine,
        numberOfDays,
        weight,
        endDateBasicsLine,
        startDate,
        endDate,
        duration,
        percentDone,
        creationDate,
        projectCardStatus,
        projectStatusColor,
        assignments,
        note,
      ];
}
