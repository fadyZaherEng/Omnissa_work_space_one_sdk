import 'package:equatable/equatable.dart';

class Strategy extends Equatable {
  final String startDate;
  final String endDate;
  final String id;
  final String name;
  final String strategyLevelName;
  final String creationDate;
  final String fullUrl;
  final String description;
  final String vision;
  final String mission;
  final String strategyStatusStr;
  final String strategyFrameworkStr;
  final String strategyPerformanceModelStr;
  final int objectivesCount;
  final int initiativesCount;

  const Strategy({
    this.startDate = '',
    this.endDate = '',
    this.id = '',
    this.name = '',
    this.strategyLevelName = '',
    this.creationDate = '',
    this.fullUrl = '',
    this.description = '',
    this.vision = '',
    this.mission = '',
    this.strategyStatusStr = '',
    this.strategyFrameworkStr = '',
    this.strategyPerformanceModelStr = '',
    this.objectivesCount = 0,
    this.initiativesCount = 0,
  });

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        id,
        name,
        strategyLevelName,
        creationDate,
        fullUrl,
        description,
        vision,
        mission,
        strategyStatusStr,
        strategyFrameworkStr,
        strategyPerformanceModelStr,
        objectivesCount,
        initiativesCount,
      ];
}
