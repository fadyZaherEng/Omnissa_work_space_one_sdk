// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_kpis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteKpis _$RemoteKpisFromJson(Map<String, dynamic> json) => RemoteKpis(
      id: json['id'] as String? ?? "",
      yearName: json['yearName'] as String? ?? "",
      kpiBankName: json['kpiBankName'] as String? ?? "",
      yeTarget: (json['yeTarget'] as num?)?.toDouble() ?? 0.0,
      departmentName: json['departmentName'] as String? ?? "",
      kpiTypeStr: json['kpiTypeStr'] as String? ?? "",
      creationDate: json['creationDate'] as String? ?? "",
      statusStr: json['statusStr'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteKpisToJson(RemoteKpis instance) =>
    <String, dynamic>{
      'id': instance.id,
      'yearName': instance.yearName,
      'kpiBankName': instance.kpiBankName,
      'yeTarget': instance.yeTarget,
      'departmentName': instance.departmentName,
      'kpiTypeStr': instance.kpiTypeStr,
      'creationDate': instance.creationDate,
      'statusStr': instance.statusStr,
    };
