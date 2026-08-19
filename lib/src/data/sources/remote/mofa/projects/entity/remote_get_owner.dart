import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/domain/entities/home/owner.dart';

part 'remote_get_owner.g.dart';

@JsonSerializable()
class RemoteGetOwner {
  final String? id;
  final String? departmentId;
  final int? departmentLevel;
  final String? totalWeight;
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

  const RemoteGetOwner({
    this.id,
    this.departmentId,
    this.departmentLevel,
    this.totalWeight,
    this.kpiType,
    this.type,
    this.name,
    this.email,
    this.prefix,
    this.isAllowed,
    this.isCorporate,
    this.key,
    this.parentId,
    this.hasApprovalAttach,
    this.crDelete,
    this.crUpdate,
  });

  factory RemoteGetOwner.fromJson(Map<String, dynamic> json) =>
      _$RemoteGetOwnerFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteGetOwnerToJson(this);
}

extension RemoteGetOwnerListMapper on List<RemoteGetOwner> {
  List<GetOwner> mapToDomain() => map((e) => e.toDomain()).toList();
}

extension RemoteGetOwnerMapperDomain on RemoteGetOwner {
  GetOwner toDomain() => GetOwner(
        id: id ?? '',
        departmentId: departmentId ?? '',
        departmentLevel: departmentLevel ?? 0,
        totalWeight: totalWeight ?? '',
        kpiType: kpiType ?? '',
        type: type ?? 0,
        name: name ?? '',
        email: email ?? '',
        prefix: prefix ?? '',
        key: key ?? '',
        parentId: parentId ?? '',
        hasApprovalAttach: hasApprovalAttach ?? false,
        crDelete: crDelete ?? false,
        crUpdate: crUpdate ?? false,
        isAllowed: isAllowed ?? false,
        isCorporate: isCorporate ?? false,
      );
}
