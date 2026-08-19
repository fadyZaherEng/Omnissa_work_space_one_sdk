import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PointersTool extends Equatable {
  final String id;
  final String yearName;
  final String kpiBankName;
  final double yeTarget;
  final String departmentName;
  final String kpiTypeStr;
  final String creationDate;
  final String status;
  final Color statusColor;

  const PointersTool({
    this.id = '',
    this.status = '',
    this.statusColor = Colors.transparent,
    this.creationDate = '',
    this.yearName = '',
    this.kpiBankName = '',
    this.yeTarget = 0,
    this.departmentName = '',
    this.kpiTypeStr = '',
  });

  @override
  List<Object?> get props => [
        id,
        status,
        statusColor,
        creationDate,
        yearName,
        kpiBankName,
        yeTarget,
        departmentName,
        kpiTypeStr,
      ];
}
