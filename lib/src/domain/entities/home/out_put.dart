import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mofa/src/domain/entities/home/output_attachments.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';

class OutPut extends Equatable {
  final String id;
  final String deliverableName;
  final String deliverableStartDate;
  final String deliverableEndDate;
  final String baselineStartDate;
  final int deliverableStatus;
  final bool hasAcceptance;
  final bool hasMileStone;
  final int completionPercentage;
  final int deliverableCategory;
  final int weight;
  final int deliverableType;
  final Status planProgress;
  final Status achievedProgress;
  final String status;
  final Color statusColor;
  final List<OutPutAttachments> attachments;
  final ProjectStatusColor projectStatusColor;
  final ProjectStatusColor deliverableStatusColor;

  const OutPut({
    this.id = '',
    this.status = '',
    this.statusColor = Colors.transparent,
    this.planProgress = const Status(),
    this.achievedProgress = const Status(),
    this.attachments = const [],
    this.deliverableName = '',
    this.deliverableStartDate = '',
    this.deliverableEndDate = '',
    this.deliverableStatus = 0,
    this.hasAcceptance = false,
    this.completionPercentage = 0,
    this.deliverableCategory = 0,
    this.weight = 0,
    this.deliverableType = 0,
    this.projectStatusColor = const ProjectStatusColor(),
    this.deliverableStatusColor = const ProjectStatusColor(),
    this.hasMileStone = false,
    this.baselineStartDate = '',
  });

  @override
  List<Object?> get props => [
        id,
        status,
        statusColor,
        planProgress,
        achievedProgress,
        attachments,
        deliverableName,
        deliverableStartDate,
        deliverableEndDate,
        deliverableStatus,
        hasAcceptance,
        completionPercentage,
        deliverableCategory,
        weight,
        deliverableType,
        projectStatusColor,
        deliverableStatusColor,
        hasMileStone,
        baselineStartDate,
      ];
}
