import 'package:json_annotation/json_annotation.dart';
import 'package:mofa/src/domain/entities/home/task.dart';

part 'remote_tasks.g.dart';

@JsonSerializable()
class RemoteTasks {
  final String? id;
  final String? name;
  final RemoteProjectName? project;
  final String? taskOwnerStr;
  final String? startDate;
  final String? endDate;
  final int? duration;
  final int? percentDone;
  final String? baselineStartDate;
  final String? baselineEndDate;
  final int? weight;
  final String? assignmentId;
  final int? draftPercentDone;
  final int? draftPriority;
  final int? draftStatus;
  final String? wfStatus;
  final String? comment;
  final bool? isOperationalTask;
  final String? requestedDepartmentStr;
  final String? assignedDepartmentStr;
  final RemoteWFStatusColor wfStatusColor;
  final RemoteWFStatusColor draftStatusObject;

  final String? taskStatusStr;
  final String? taskPriorityStr;

  const RemoteTasks(
      {this.id = "",
      this.name = "",
      this.project = const RemoteProjectName(),
      this.taskOwnerStr = "",
      this.startDate = "",
      this.endDate = "",
      this.duration = 0,
      this.percentDone = 0,
      this.baselineStartDate = "",
      this.baselineEndDate = "",
      this.weight = 0,
      this.assignmentId = "",
      this.draftPercentDone = 0,
      this.draftPriority = 0,
      this.draftStatus = 0,
      this.wfStatus = "",
      this.isOperationalTask = false,
      this.requestedDepartmentStr = "",
      this.assignedDepartmentStr = "",
      this.wfStatusColor = const RemoteWFStatusColor(),
      this.draftStatusObject = const RemoteWFStatusColor(),
      this.comment = "",
      this.taskStatusStr = "",
      this.taskPriorityStr = ""});

  factory RemoteTasks.fromJson(Map<String, dynamic> json) =>
      _$RemoteTasksFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteTasksToJson(this);
}

@JsonSerializable()
class RemoteWFStatusColor {
  final String? color;
  final String? label;

  const RemoteWFStatusColor({
    this.color = "",
    this.label = "",
  });

  factory RemoteWFStatusColor.fromJson(Map<String, dynamic> json) =>
      _$RemoteWFStatusColorFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteWFStatusColorToJson(this);
}

extension ToDomainColor on RemoteWFStatusColor {
  WFStatusColor toDomain() => WFStatusColor(
        color: color ?? '',
        label: label ?? '',
      );
}

extension ToDomain on RemoteTasks {
  Task toDomain() => Task(
        id: id ?? '',
        name: name ?? '',
        taskOwnerStr: taskOwnerStr ?? '',
        duration: duration ?? 0,
        percentDone: percentDone ?? 0,
        baselineStartDate: baselineStartDate ?? '',
        baselineEndDate: baselineEndDate ?? '',
        weight: weight ?? 0,
        assignmentId: assignmentId ?? '',
        draftPercentDone: draftPercentDone ?? 0,
        draftPriority: draftPriority ?? 0,
        draftStatus: draftStatus ?? 0,
        wfStatus: wfStatus ?? '',
        taskEndDate: endDate ?? '',
        taskStartDate: startDate ?? '',
        project: project?.toDomain() ?? const ProjectModel(),
        isOperationalTask: isOperationalTask ?? false,
        requestedDepartmentStr: requestedDepartmentStr ?? '',
        assignedDepartmentStr: assignedDepartmentStr ?? '',
        wfStatusColor: wfStatusColor.toDomain(),
        draftStatusObject: draftStatusObject.toDomain(),
        comment: comment ?? '',
        taskStatusStr: taskStatusStr ?? '',
        taskPriorityStr: taskPriorityStr ?? '',
      );
}

extension ToDomainTasks on List<RemoteTasks> {
  List<Task> toDomain() => map((e) => e.toDomain()).toList();
}

@JsonSerializable()
class RemoteProjectName {
  final String? projectName;
  final String? projectManagerName;

  const RemoteProjectName({
    this.projectName = "",
    this.projectManagerName = "",
  });

  factory RemoteProjectName.fromJson(Map<String, dynamic> json) =>
      _$RemoteProjectNameFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteProjectNameToJson(this);
}

extension ToDomainProjectName on RemoteProjectName {
  ProjectModel toDomain() => ProjectModel(
        projectName: projectName ?? '',
        projectManagerName: projectManagerName ?? '',
      );
}
