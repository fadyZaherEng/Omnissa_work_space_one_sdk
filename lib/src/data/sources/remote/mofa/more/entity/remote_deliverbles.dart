import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_get_all_projects.dart';
import 'package:mofa/src/domain/entities/home/deliverables.dart';
import 'package:mofa/src/domain/entities/home/project.dart';

part 'remote_deliverbles.g.dart';

@JsonSerializable()
class RemoteDeliverbles {
  final String? id;
  final String? projectName;
  final String? projectManagerStr;
  final String? description;
  final String? specificationsStandards;
  final int? weight;
  final String? deliverableName;
  final String? deliverableStartDate;
  final String? deliverableEndDate;
  final double? completionPercentage;
  final String? deliverableStatusStr;
  final String? owner;
  final int? deliverableType;
  final bool? hasMileStone;
  final String? projectStartDate;
  final String? projectEndDate;
  final String? baselineStartDate;
  final String? baselineEndDate;
  final String? deliveryDate;
  final int? deliverableValue;
  final RemoteProjectStatusColor? deliverableStatusColor;

  const RemoteDeliverbles({
    this.id = '',
    this.projectName = '',
    this.projectManagerStr = '',
    this.weight = 0,
    this.deliverableName = '',
    this.deliverableStartDate = '',
    this.deliverableEndDate = '',
    this.completionPercentage = 0,
    this.deliverableStatusStr = '',
    this.owner = '',
    this.deliverableType = 0,
    this.hasMileStone = false,
    this.projectStartDate = '',
    this.projectEndDate = '',
    this.baselineStartDate = '',
    this.baselineEndDate = '',
    this.deliveryDate = '',
    this.deliverableValue = 0,
    this.deliverableStatusColor = const RemoteProjectStatusColor(),
    this.description = '',
    this.specificationsStandards = '',
  });

  factory RemoteDeliverbles.fromJson(Map<String, dynamic> json) =>
      _$RemoteDeliverblesFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteDeliverblesToJson(this);
}

extension RemoteDeliverblesExtension on RemoteDeliverbles {
  Deliverbles mapToDeliverbles() => Deliverbles(
        id: id ?? '',
        projectName: projectName ?? '',
        projectManagerStr: projectManagerStr ?? '',
        weight: weight ?? 0,
        deliverableName: deliverableName ?? '',
        deliverableStartDate: deliverableStartDate ?? '',
        deliverableEndDate: deliverableEndDate ?? '',
        completionPercentage: completionPercentage ?? 0.0,
        deliverableStatusColor:
            deliverableStatusColor?.mapToDomain() ?? const ProjectStatusColor(),
        owner: owner ?? '',
        deliverableType: deliverableType ?? 0,
        hasMileStone: hasMileStone ?? false,
        projectStartDate: projectStartDate ?? '',
        projectEndDate: projectEndDate ?? '',
        baselineStartDate: baselineStartDate ?? '',
        baselineEndDate: baselineEndDate ?? '',
        deliveryDate: deliveryDate ?? '',
        deliverableValue: deliverableValue ?? 0,
        specificationsStandards: specificationsStandards ?? '',
        description: description ?? '',
      );
}

extension ListRemoteDeliverblesExtension on List<RemoteDeliverbles> {
  List<Deliverbles> mapToDeliverbles() =>
      map((e) => e.mapToDeliverbles()).toList();
}
