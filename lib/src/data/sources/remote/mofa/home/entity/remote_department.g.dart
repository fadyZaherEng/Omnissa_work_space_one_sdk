// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteDepartment _$RemoteDepartmentFromJson(Map<String, dynamic> json) =>
    RemoteDepartment(
      id: json['id'] as String? ?? "",
      departmentId: json['departmentId'] as String? ?? "",
      departmentLevel: (json['departmentLevel'] as num?)?.toInt() ?? 0,
      totalWeight: (json['totalWeight'] as num?)?.toDouble() ?? 0,
      kpiType: json['kpiType'] as String? ?? "",
      type: (json['type'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? "",
      email: json['email'] as String? ?? "",
      prefix: json['prefix'] as String? ?? "",
      isAllowed: json['isAllowed'] as bool? ?? false,
      isCorporate: json['isCorporate'] as bool? ?? false,
      key: json['key'] as String? ?? "",
      parentId: json['parentId'] as String? ?? "",
      hasApprovalAttach: json['hasApprovalAttach'] as bool? ?? false,
      crDelete: json['crDelete'] as bool? ?? false,
      crUpdate: json['crUpdate'] as bool? ?? false,
    );

Map<String, dynamic> _$RemoteDepartmentToJson(RemoteDepartment instance) =>
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
