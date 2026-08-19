import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';

class Information extends Equatable {
  final String id;
  final String managerName;
  final String startDate;
  final String endDate;
  final Status planProgress;
  final Status achievedProgress;
  final String status;
  final Color statusColor;

  const Information({
    this.id = '',
    this.managerName = '',
    this.startDate = '',
    this.endDate = '',
    this.status = '',
    this.statusColor = Colors.transparent,
    this.planProgress = const Status(),
    this.achievedProgress = const Status(),
  });

  @override
  List<Object?> get props => [
        id,
        managerName,
        startDate,
        endDate,
        status,
        statusColor,
        planProgress,
        achievedProgress,
      ];
}
