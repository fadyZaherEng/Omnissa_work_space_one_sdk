import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/domain/entities/home/pointers_tool.dart';

part 'remote_kpis.g.dart';

@JsonSerializable()
class RemoteKpis {
  final String? id;
  final String? yearName;
  final String? kpiBankName;
  final double? yeTarget;
  final String? departmentName;
  final String? kpiTypeStr;
  final String? creationDate;
  final String? statusStr;

  const RemoteKpis({
    this.id = "",
    this.yearName = "",
    this.kpiBankName = "",
    this.yeTarget = 0.0,
    this.departmentName = "",
    this.kpiTypeStr = "",
    this.creationDate = "",
    this.statusStr = "",
  });

  factory RemoteKpis.fromJson(Map<String, dynamic> json) =>
      _$RemoteKpisFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteKpisToJson(this);
}

extension ToDomain on RemoteKpis {
  PointersTool toDomain() => PointersTool(
        id: id ?? '',
        yearName: yearName ?? '',
        kpiBankName: kpiBankName ?? '',
        yeTarget: yeTarget ?? 0.0,
        departmentName: departmentName ?? '',
        kpiTypeStr: kpiTypeStr ?? '',
        creationDate: creationDate ?? '',
        status: statusStr ?? '',
      );
}

extension RemoteKpisListExtension on List<RemoteKpis> {
  List<PointersTool> toDomain() => map((e) => e.toDomain()).toList();
}
