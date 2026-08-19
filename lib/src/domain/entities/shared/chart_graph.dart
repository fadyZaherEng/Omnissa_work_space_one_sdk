import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ChartGraph extends Equatable {
  final String x;
  final int y;
  final Color color;

  const ChartGraph({
    required this.x,
    required this.y,
    required this.color,
  });

  @override
  List<Object?> get props => [x, y, color];
}
