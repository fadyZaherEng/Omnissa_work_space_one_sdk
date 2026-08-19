import 'package:equatable/equatable.dart';

class Department extends Equatable {
  final String id;
  final String departmentId;
  final int departmentLevel;
  final double totalWeight;
  final String kpiType;
  final int type;
  final String name;
  final String email;
  final String prefix;
  final bool isAllowed;
  final bool isCorporate;
  final String key;
  final String parentId;
  final bool hasApprovalAttach;
  final bool crDelete;
  final bool crUpdate;

  const Department({
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

  @override
  List<Object?> get props => [
        id,
        departmentId,
        departmentLevel,
        totalWeight,
        kpiType,
        type,
        name,
        email,
        prefix,
        isAllowed,
        isCorporate,
        key,
        parentId,
        hasApprovalAttach,
        crDelete,
        crUpdate,
      ];
}
