import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_get_all_projects.dart';
import 'package:mofa/src/domain/entities/home/out_put.dart';

part 'remote_delivery.g.dart';

@JsonSerializable()
class RemoteDelivery {
  final String? id;
  final String? deliverableName;
  final String? deliverableStartDate;
  final String? deliverableEndDate;
  final String? baselineStartDate;
  final int? deliverableStatus;
  final bool? hasAcceptance;
  final bool? hasMileStone;
  final int? completionPercentage;
  final int? deliverableCategory;
  final int? weight;
  final int? deliverableType;
  final RemoteProjectStatusColor projectStatusColor;
  final RemoteProjectStatusColor deliverableStatusColor;

  const RemoteDelivery({
    this.id = '',
    this.deliverableName = '',
    this.deliverableStartDate = '',
    this.deliverableEndDate = '',
    this.deliverableStatus = 0,
    this.hasAcceptance = false,
    this.completionPercentage = 0,
    this.deliverableCategory = 0,
    this.weight = 0,
    this.deliverableType = 0,
    this.projectStatusColor = const RemoteProjectStatusColor(),
    this.hasMileStone = false,
    this.deliverableStatusColor = const RemoteProjectStatusColor(),
    this.baselineStartDate = '',
  });

  factory RemoteDelivery.fromJson(Map<String, dynamic> json) =>
      _$RemoteDeliveryFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteDeliveryToJson(this);
}

extension RemoteDeliveryMapper on RemoteDelivery {
  OutPut mapToDomain() => OutPut(
        id: id ?? '',
        deliverableName: deliverableName ?? '',
        deliverableStartDate: deliverableStartDate ?? '',
        deliverableEndDate: deliverableEndDate ?? '',
        deliverableStatus: deliverableStatus ?? 0,
        hasAcceptance: hasAcceptance ?? false,
        completionPercentage: completionPercentage ?? 0,
        deliverableCategory: deliverableCategory ?? 0,
        weight: weight ?? 0,
        deliverableType: deliverableType ?? 0,
        projectStatusColor: projectStatusColor.mapToDomain(),
        hasMileStone: hasMileStone ?? false,
        deliverableStatusColor: deliverableStatusColor.mapToDomain(),
        baselineStartDate: baselineStartDate ?? '',
      );
}

extension RemoteDeliveryListMapper on List<RemoteDelivery> {
  List<OutPut> mapToDomain() => map((e) => e.mapToDomain()).toList();
}
