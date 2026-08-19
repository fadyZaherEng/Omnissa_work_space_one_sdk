import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/domain/entities/home/complinace.dart';

part 'remote_complince.g.dart';

@JsonSerializable()
class RemoteCompliance {
  final String id;
  final String taskName;
  final String activityName;
  final String processName;
  final String phaseName;
  final String stageName;
  final double mark;
  final String complianceRateStr;
  final int complianceRate;
  final String discoveryDate;
  final String resolutionDate;
  final String recommendations;
  final String observation;

  const RemoteCompliance({
    this.id = "",
    this.taskName = "",
    this.activityName = "",
    this.processName = "",
    this.phaseName = "",
    this.stageName = "",
    this.mark = 0,
    this.complianceRateStr = "",
    this.complianceRate = 0,
    this.discoveryDate = "",
    this.resolutionDate = "",
    this.recommendations = "",
    this.observation = "",
  });

  factory RemoteCompliance.fromJson(Map<String, dynamic> json) =>
      _$RemoteComplianceFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteComplianceToJson(this);
}
extension RemoteComplianceExt on RemoteCompliance {
  Complinace mapToDomain() {
    return Complinace(
      id: id ?? '',
      taskName: taskName ?? '',
      activityName: activityName ?? '',
      processName: processName ?? '',
      phaseName: phaseName ?? '',
      stageName: stageName ?? '',
      mark: mark ?? 0,
      complianceRateStr: complianceRateStr ?? '',
      complianceRate: complianceRate ?? 0,
      discoveryDate: discoveryDate ?? '',
      resolutionDate: resolutionDate ?? '',
      recommendations: recommendations ?? '',
      observation: observation ?? '',
    );
  }
}
extension ListRemoteComplianceExt on List<RemoteCompliance> {
  List<Complinace> mapToDomain() {
    return map((e) => e.mapToDomain()).toList();
  }
}