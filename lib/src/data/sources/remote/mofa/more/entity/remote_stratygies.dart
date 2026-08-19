import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/domain/entities/home/stratgy.dart';

part 'remote_stratygies.g.dart';

@JsonSerializable()
class RemoteStratygies {
  final String? id;
  final String? name;
  final String? startDate;
  final String? endDate;
  final String? strategyLevelName;
  final String? creationDate;
  final String? fullUrl;
  final String? description;
  final String? vision;
  final String? mission;
  final String? strategyStatusStr;
  final String? strategyFrameworkStr;
  final String? strategyPerformanceModelStr;
  final int? objectivesCount;
  final int? initiativesCount;
  const RemoteStratygies({
    this.id = '',
    this.name = '',
    this.startDate = '',
    this.endDate = '',
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

  factory RemoteStratygies.fromJson(Map<String, dynamic> json) =>
      _$RemoteStratygiesFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteStratygiesToJson(this);
}

extension RemoteStratygiesExt on RemoteStratygies {
  Strategy mapToDomain() => Strategy(
        id: id ?? '',
        name: name ?? '',
        startDate: startDate ?? '',
        endDate: endDate ?? '',
        strategyLevelName: strategyLevelName ?? '',
        creationDate: creationDate ?? '',
        fullUrl: fullUrl ?? '',
        description: description ?? '',
        vision: vision ?? '',
        mission: mission ?? '',
        strategyStatusStr: strategyStatusStr ?? '',
        strategyFrameworkStr: strategyFrameworkStr ?? '',
        strategyPerformanceModelStr: strategyPerformanceModelStr ?? '',
        objectivesCount: objectivesCount ?? 0,
        initiativesCount: initiativesCount ?? 0,
      );
}

extension RemoteStratygiesListExt on List<RemoteStratygies> {
  List<Strategy> mapToDomain() => map((e) => e.mapToDomain()).toList();
}
