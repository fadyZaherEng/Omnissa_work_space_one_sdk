import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_complince.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_delivery.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_get_all_projects.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_issues.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_milstone.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_risks.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/home/project_details.dart';

part 'remote_project_full_details.g.dart';

@JsonSerializable()
class RemoteProjectFullDetails {
  final RemoteGetAllProjects? project; //nfo
  final List<RemoteDelivery>? deliverables; //output
  final List<RemoteMilestones>? milestones; //landmark
  final List<RemoteIssues>? issues; //challenge
  final List<RemoteRisks>? risks; //risk
  final List<RemoteCompliance>? compliance; //risk
  //assumptions = notes

  const RemoteProjectFullDetails({
    this.project = const RemoteGetAllProjects(),
    this.deliverables = const [],
    this.milestones = const [],
    this.issues = const [],
    this.risks = const [],
    this.compliance = const [],
  });

  factory RemoteProjectFullDetails.fromJson(Map<String, dynamic> json) =>
      _$RemoteProjectFullDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteProjectFullDetailsToJson(this);
}

extension RemoteProjectFullDetailsExt on RemoteProjectFullDetails {
  ProjectDetails mapToDomain() {
    return ProjectDetails(
      project: project?.mapToDomain() ?? const Project(),
      deliverables: deliverables?.map((e) => e.mapToDomain()).toList() ?? [],
      milestones: milestones?.map((e) => e.mapToLandmark()).toList() ?? [],
      issues: issues?.map((e) => e.mapToDomain()).toList() ?? [],
      risks: risks?.map((e) => e.mapToDomain()).toList() ?? [],
      compliance: compliance?.map((e) => e.mapToDomain()).toList() ?? [],
    );
  }
}
