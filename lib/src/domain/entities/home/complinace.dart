import 'package:equatable/equatable.dart';

class Complinace extends Equatable {
  final String id;
  final String taskName;
  final String activityName;
  final String processName;
  final String phaseName;
  final String stageName;
  final double mark;
  final String complianceRateStr;
  final int complianceRate;
  final String discoveryDate;
  final String resolutionDate;
  final String recommendations;
  final String observation;

  const Complinace({
    this.id = '',
    this.taskName = '',
    this.activityName = '',
    this.processName = '',
    this.phaseName = '',
    this.stageName = '',
    this.mark = 0.0,
    this.complianceRateStr = '',
    this.complianceRate = 0,
    this.discoveryDate = '',
    this.resolutionDate = '',
    this.recommendations = '',
    this.observation = '',
  });

  @override
  List<Object?> get props => [
        id,
        taskName,
        activityName,
        processName,
        phaseName,
        stageName,
        mark,
        complianceRateStr,
        complianceRate,
        discoveryDate,
        resolutionDate,
        recommendations,
        observation,
      ];
}
