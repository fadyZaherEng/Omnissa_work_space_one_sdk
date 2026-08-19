import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_milstone.dart';

part 'remore_milstone_details.g.dart';

@JsonSerializable()
class RemoteMilstoneDetails {
  final String? id;
  final String? name;
  final RemoteMilstoneDetailsProject? project;
  final String? startDate;
  final String? endDate;
  final bool? isOperationalTask;
  final int? duration;
  final dynamic percentDone;
  final String? baselineStartDate;
  final String? baselineEndDate;
  final int? weight;
  final dynamic taskOwnerStr;
  final dynamic requestedDepartmentStr;
  final dynamic assignedDepartmentStr;
  final dynamic note;
  final List<RemoteAssignments>? assignments;

  const RemoteMilstoneDetails({
    this.id,
    this.name,
    this.project,
    this.startDate,
    this.endDate,
    this.isOperationalTask,
    this.duration,
    this.percentDone,
    this.baselineStartDate,
    this.baselineEndDate,
    this.weight,
    this.taskOwnerStr,
    this.requestedDepartmentStr,
    this.assignedDepartmentStr,
    this.note,
    this.assignments,
  });

  factory RemoteMilstoneDetails.fromJson(Map<String, dynamic> json) =>
      _$RemoteMilstoneDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteMilstoneDetailsToJson(this);
}

@JsonSerializable()
class RemoteMilstoneDetailsProject {
  final String? projectName;
  final String? projectManagerStr;

  const RemoteMilstoneDetailsProject({
    this.projectName,
    this.projectManagerStr,
  });

  factory RemoteMilstoneDetailsProject.fromJson(Map<String, dynamic> json) =>
      _$RemoteMilstoneDetailsProjectFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteMilstoneDetailsProjectToJson(this);
}
