import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_get_all_projects.dart';
import 'package:mofa/src/domain/entities/home/land_mark.dart';

part 'remote_milstone.g.dart';

@JsonSerializable()
class RemoteMilestones {
  final String? id;
  final String? name;
  final String? parentName;
  final String? startDate;
  final String? endDate;
  final int? duration;
  final int? percentDone;
  final String? baselineStartDate;
  final String? baselineEndDate;
  final int? weight;
  final String? creationDate;
  final int? projectCardStatus;
  final RemoteProjectStatusColor projectCardStatusStr;
  final RemoteProjectStatusColor statusColor;
  final List<RemoteAssignments>? assignments;
  final String? note;

  const RemoteMilestones({
    this.id = '',
    this.name = '',
    this.startDate = '',
    this.endDate = '',
    this.duration = 0,
    this.percentDone = 0,
    this.baselineStartDate = '',
    this.baselineEndDate = '',
    this.weight = 0,
    this.creationDate = '',
    this.projectCardStatus = 0,
    this.parentName = '',
    this.projectCardStatusStr = const RemoteProjectStatusColor(),
    this.statusColor = const RemoteProjectStatusColor(),
    this.assignments = const [],
    this.note = '',
  });

  factory RemoteMilestones.fromJson(Map<String, dynamic> json) =>
      _$RemoteMilestonesFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteMilestonesToJson(this);
}

@JsonSerializable()
class RemoteAssignments {
  final String? resourceName;
  final String? id;
  final String? taskId;
  final String? resourceId;
  final int? units;
  final List<dynamic>? assignmentHistory;

  const RemoteAssignments({
    this.resourceName = '',
    this.id = '',
    this.taskId = '',
    this.resourceId = '',
    this.units = 0,
    this.assignmentHistory = const [],
  });

  factory RemoteAssignments.fromJson(Map<String, dynamic> json) =>
      _$RemoteAssignmentsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteAssignmentsToJson(this);
}

extension RemoteAssignmentsExtension on RemoteAssignments {
  Assignments mapToDomain() => Assignments(
        resourceName: resourceName ?? '',
        id: id ?? '',
        taskId: taskId ?? '',
        resourceId: resourceId ?? '',
        units: units ?? 0,
        assignmentHistory: assignmentHistory
                ?.map((e) => AssignmentHistory(
                      date: e['date'] ?? '',
                      units: e['units'] ?? 0,
                    ))
                .toList() ??
            [],
      );
}

extension RemoteMilestonesExtension on RemoteMilestones {
  Landmark mapToLandmark() => Landmark(
        name: name ?? '',
        id: id ?? '',
        managerName: parentName ?? '',
        duration: duration ?? 0,
        startDate: startDate ?? '',
        endDate: endDate ?? '',
        percentDone: percentDone ?? 0,
        startDateBasicsLine: baselineStartDate ?? '',
        endDateBasicsLine: baselineEndDate ?? '',
        weight: weight ?? 0,
        creationDate: creationDate ?? '',
        projectCardStatus: projectCardStatus ?? 0,
        projectStatusColor: projectCardStatusStr.mapToDomain(),
        assignments: assignments?.map((e) => e.mapToDomain()).toList() ?? [],
        note: note ?? '',
      );
}
