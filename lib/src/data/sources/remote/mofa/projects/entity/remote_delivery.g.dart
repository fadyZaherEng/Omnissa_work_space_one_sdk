// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_delivery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteDelivery _$RemoteDeliveryFromJson(Map<String, dynamic> json) =>
    RemoteDelivery(
      id: json['id'] as String? ?? '',
      deliverableName: json['deliverableName'] as String? ?? '',
      deliverableStartDate: json['deliverableStartDate'] as String? ?? '',
      deliverableEndDate: json['deliverableEndDate'] as String? ?? '',
      deliverableStatus: (json['deliverableStatus'] as num?)?.toInt() ?? 0,
      hasAcceptance: json['hasAcceptance'] as bool? ?? false,
      completionPercentage:
          (json['completionPercentage'] as num?)?.toInt() ?? 0,
      deliverableCategory: (json['deliverableCategory'] as num?)?.toInt() ?? 0,
      weight: (json['weight'] as num?)?.toInt() ?? 0,
      deliverableType: (json['deliverableType'] as num?)?.toInt() ?? 0,
      projectStatusColor: json['projectStatusColor'] == null
          ? const RemoteProjectStatusColor()
          : RemoteProjectStatusColor.fromJson(
              json['projectStatusColor'] as Map<String, dynamic>),
      hasMileStone: json['hasMileStone'] as bool? ?? false,
      deliverableStatusColor: json['deliverableStatusColor'] == null
          ? const RemoteProjectStatusColor()
          : RemoteProjectStatusColor.fromJson(
              json['deliverableStatusColor'] as Map<String, dynamic>),
      baselineStartDate: json['baselineStartDate'] as String? ?? '',
    );

Map<String, dynamic> _$RemoteDeliveryToJson(RemoteDelivery instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deliverableName': instance.deliverableName,
      'deliverableStartDate': instance.deliverableStartDate,
      'deliverableEndDate': instance.deliverableEndDate,
      'baselineStartDate': instance.baselineStartDate,
      'deliverableStatus': instance.deliverableStatus,
      'hasAcceptance': instance.hasAcceptance,
      'hasMileStone': instance.hasMileStone,
      'completionPercentage': instance.completionPercentage,
      'deliverableCategory': instance.deliverableCategory,
      'weight': instance.weight,
      'deliverableType': instance.deliverableType,
      'projectStatusColor': instance.projectStatusColor,
      'deliverableStatusColor': instance.deliverableStatusColor,
    };
