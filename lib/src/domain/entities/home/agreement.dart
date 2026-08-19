import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Agreements extends Equatable {
  final String title;
  final String id;
  final String agreementName;
  final String creationDate;
  final String status;
  final Color statusColor;

  const Agreements({
    this.title = '',
    this.id = '',
    this.agreementName = '',
    this.creationDate = '',
    this.status = '',
    this.statusColor = Colors.transparent,
  });

  @override
  List<Object?> get props => [
        title,
        id,
        agreementName,
        creationDate,
        status,
        statusColor,
      ];
}
