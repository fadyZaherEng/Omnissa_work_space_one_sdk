// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_get_owner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteGetOwner _$RemoteGetOwnerFromJson(Map<String, dynamic> json) =>
    RemoteGetOwner(
      id: json['id'] as String?,
      departmentId: json['departmentId'] as String?,
      departmentLevel: (json['departmentLevel'] as num?)?.toInt(),
      totalWeight: json['totalWeight'] as String?,
      kpiType: json['kpiType'] as String?,
      type: (json['type'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      prefix: json['prefix'] as String?,
      isAllowed: json['isAllowed'] as bool?,
      isCorporate: json['isCorporate'] as bool?,
      key: json['key'] as String?,
      parentId: json['parentId'] as String?,
      hasApprovalAttach: json['hasApprovalAttach'] as bool?,
      crDelete: json['crDelete'] as bool?,
      crUpdate: json['crUpdate'] as bool?,
    );

Map<String, dynamic> _$RemoteGetOwnerToJson(RemoteGetOwner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'departmentId': instance.departmentId,
      'departmentLevel': instance.departmentLevel,
      'totalWeight': instance.totalWeight,
      'kpiType': instance.kpiType,
      'type': instance.type,
      'name': instance.name,
      'email': instance.email,
      'prefix': instance.prefix,
      'isAllowed': instance.isAllowed,
      'isCorporate': instance.isCorporate,
      'key': instance.key,
      'parentId': instance.parentId,
      'hasApprovalAttach': instance.hasApprovalAttach,
      'crDelete': instance.crDelete,
      'crUpdate': instance.crUpdate,
    };
