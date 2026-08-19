// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_deliverbles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteDeliverbles _$RemoteDeliverblesFromJson(Map<String, dynamic> json) =>
    RemoteDeliverbles(
      id: json['id'] as String? ?? '',
      projectName: json['projectName'] as String? ?? '',
      projectManagerStr: json['projectManagerStr'] as String? ?? '',
      weight: (json['weight'] as num?)?.toInt() ?? 0,
      deliverableName: json['deliverableName'] as String? ?? '',
      deliverableStartDate: json['deliverableStartDate'] as String? ?? '',
      deliverableEndDate: json['deliverableEndDate'] as String? ?? '',
      completionPercentage:
          (json['completionPercentage'] as num?)?.toDouble() ?? 0,
      deliverableStatusStr: json['deliverableStatusStr'] as String? ?? '',
      owner: json['owner'] as String? ?? '',
      deliverableType: (json['deliverableType'] as num?)?.toInt() ?? 0,
      hasMileStone: json['hasMileStone'] as bool? ?? false,
      projectStartDate: json['projectStartDate'] as String? ?? '',
      projectEndDate: json['projectEndDate'] as String? ?? '',
      baselineStartDate: json['baselineStartDate'] as String? ?? '',
      baselineEndDate: json['baselineEndDate'] as String? ?? '',
      deliveryDate: json['deliveryDate'] as String? ?? '',
      deliverableValue: (json['deliverableValue'] as num?)?.toInt() ?? 0,
      deliverableStatusColor: json['deliverableStatusColor'] == null
          ? const RemoteProjectStatusColor()
          : RemoteProjectStatusColor.fromJson(
              json['deliverableStatusColor'] as Map<String, dynamic>),
      description: json['description'] as String? ?? '',
      specificationsStandards: json['specificationsStandards'] as String? ?? '',
    );

Map<String, dynamic> _$RemoteDeliverblesToJson(RemoteDeliverbles instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectName': instance.projectName,
      'projectManagerStr': instance.projectManagerStr,
      'description': instance.description,
      'specificationsStandards': instance.specificationsStandards,
      'weight': instance.weight,
      'deliverableName': instance.deliverableName,
      'deliverableStartDate': instance.deliverableStartDate,
      'deliverableEndDate': instance.deliverableEndDate,
      'completionPercentage': instance.completionPercentage,
      'deliverableStatusStr': instance.deliverableStatusStr,
      'owner': instance.owner,
      'deliverableType': instance.deliverableType,
      'hasMileStone': instance.hasMileStone,
      'projectStartDate': instance.projectStartDate,
      'projectEndDate': instance.projectEndDate,
      'baselineStartDate': instance.baselineStartDate,
      'baselineEndDate': instance.baselineEndDate,
      'deliveryDate': instance.deliveryDate,
      'deliverableValue': instance.deliverableValue,
      'deliverableStatusColor': instance.deliverableStatusColor,
    };
