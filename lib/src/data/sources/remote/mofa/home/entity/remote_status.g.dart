// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteStatus _$RemoteStatusFromJson(Map<String, dynamic> json) => RemoteStatus(
      id: (json['id'] as num?)?.toInt() ?? 0,
      order: (json['order'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      nameAr: json['nameAr'] as String? ?? '',
      isAllowed: json['isAllowed'] as bool? ?? false,
      isDisabled: json['isDisabled'] as bool? ?? false,
      isForm: json['isForm'] as bool? ?? false,
      projectTab: (json['projectTab'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RemoteStatusToJson(RemoteStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'name': instance.name,
      'nameAr': instance.nameAr,
      'isAllowed': instance.isAllowed,
      'isDisabled': instance.isDisabled,
      'isForm': instance.isForm,
      'projectTab': instance.projectTab,
    };
