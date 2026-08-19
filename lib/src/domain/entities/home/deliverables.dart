import 'package:equatable/equatable.dart';
import 'package:mofa/src/domain/entities/home/project.dart';

class Deliverbles extends Equatable {
  final String id;
  final String projectName;
  final String projectManagerStr;
  final int weight;
  final String deliverableName;
  final String specificationsStandards;
  final String description;
  final String deliverableStartDate;
  final String deliverableEndDate;
  final double completionPercentage;
  final ProjectStatusColor deliverableStatusColor;
  final String owner;
  final int deliverableType;
  final bool hasMileStone;
  final String projectStartDate;
  final String projectEndDate;
  final String baselineStartDate;
  final String baselineEndDate;
  final String deliveryDate;
  final int deliverableValue;

  const Deliverbles({
    this.id = '',
    this.projectName = '',
    this.projectManagerStr = '',
    this.weight = 0,
    this.deliverableName = '',
    this.deliverableStartDate = '',
    this.deliverableEndDate = '',
    this.completionPercentage = 0,
    this.deliverableStatusColor = const ProjectStatusColor(),
    this.owner = '',
    this.deliverableType = 0,
    this.hasMileStone = false,
    this.projectStartDate = '',
    this.projectEndDate = '',
    this.baselineStartDate = '',
    this.baselineEndDate = '',
    this.deliveryDate = '',
    this.deliverableValue = 0,
    this.specificationsStandards = '',
    this.description = '',
  });

  @override
  List<Object?> get props => [
        id,
        projectName,
        projectManagerStr,
        weight,
        deliverableName,
        deliverableStartDate,
        deliverableEndDate,
        completionPercentage,
        deliverableStatusColor,
        owner,
        deliverableType,
        hasMileStone,
        projectStartDate,
        projectEndDate,
        baselineStartDate,
        baselineEndDate,
        deliveryDate,
        deliverableValue,
        specificationsStandards,
        description
      ];
}
