import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/domain/entities/home/department.dart';

part 'remote_department.g.dart';

@JsonSerializable()
class RemoteDepartment {
  final String? id;
  final String? departmentId;
  final int? departmentLevel;
  final double? totalWeight;
  final String? kpiType;
  final int? type;
  final String? name;
  final String? email;
  final String? prefix;
  final bool? isAllowed;
  final bool? isCorporate;
  final String? key;
  final String? parentId;
  final bool? hasApprovalAttach;
  final bool? crDelete;
  final bool? crUpdate;

  const RemoteDepartment({
    this.id = "",
    this.departmentId = "",
    this.departmentLevel = 0,
    this.totalWeight = 0,
    this.kpiType = "",
    this.type = 0,
    this.name = "",
    this.email = "",
    this.prefix = "",
    this.isAllowed = false,
    this.isCorporate = false,
    this.key = "",
    this.parentId = "",
    this.hasApprovalAttach = false,
    this.crDelete = false,
    this.crUpdate = false,
  });

  factory RemoteDepartment.fromJson(Map<String, dynamic> json) =>
      _$RemoteDepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteDepartmentToJson(this);
}

extension RemoteDepartmentExtension on RemoteDepartment {
  Department toDomain() => Department(
        id: id ?? '',
        departmentId: departmentId ?? '',
        departmentLevel: departmentLevel ?? 0,
        totalWeight: totalWeight ?? 0,
        kpiType: kpiType ?? '',
        type: type ?? 0,
        name: name ?? '',
        email: email ?? '',
        prefix: prefix ?? '',
        isAllowed: isAllowed ?? false,
        isCorporate: isCorporate ?? false,
        key: key ?? '',
        parentId: parentId ?? '',
        hasApprovalAttach: hasApprovalAttach ?? false,
        crDelete: crDelete ?? false,
        crUpdate: crUpdate ?? false,
      );
}

extension RemoteDepartmentsExtension on List<RemoteDepartment> {
  List<Department> toDomain() => map((e) => e.toDomain()).toList();
}
