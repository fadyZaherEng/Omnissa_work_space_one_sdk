import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remore_milstone_details.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_handle_form_approval.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_save_project_latest.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_task_update.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_update_milstone.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_update_tasks.dart';
import 'package:mofa/src/domain/entities/home/challenges.dart';
import 'package:mofa/src/domain/entities/home/deliverables.dart';
import 'package:mofa/src/domain/entities/home/form_approval.dart';
import 'package:mofa/src/domain/entities/home/milstones.dart' as Milstones;
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/home/risks.dart';
import 'package:mofa/src/domain/entities/home/stratgy.dart';
import 'package:mofa/src/domain/entities/home/task.dart';
import 'package:mofa/src/domain/entities/home/task_enum.dart';
import 'package:mofa/src/domain/entities/home/task_update_approval.dart';

abstract class MoreRepository {
  Future<DataState<List<Challenges>>> getIssues({
    required int pageSize,
    required int skip,
    required String departmentId,
    required int statusId,
    required int priorityId,
    required String searchFilterDefinition,
    required String searchValue,
    required String sortColumnDirection,
    required String columnDirection,
  });

  Future<DataState<List<Risks>>> getRisks({
    required int pageSize,
    required int skip,
    required String departmentId,
    required int statusId,
    required int priorityId,
    required String searchFilterDefinition,
    required String searchValue,
    required String sortColumnDirection,
    required String columnDirection,
  });

  Future<DataState<List<TaskBoardEnum>>> getTaskboardStatus();

  Future<DataState<List<TaskBoardEnum>>> getTaskboardPriority();

  Future<DataState<Challenges>> getIssueInfo({
    required String id,
  });

  Future<DataState<Risks>> getRiskInfo({
    required String id,
  });

  Future<DataState<List<Project>>> getInitiatives({
    required int pageSize,
    required int skip,
    required String sortColumnDirection,
    required String columnDirection,
  });

  Future<DataState<List<Task>>> getTasks({
    required int pageSize,
    required int skip,
    required String searchValue,
    required String searchFilterDefinition,
    required String sortColumnDirection,
    required String columnDirection,
  });

  Future<DataState<RemoteMilstoneDetails>> getTaskInfo({
    required String id,
    required int pageSize,
    required int skip,
    required String sortColumnDirection,
    required String columnDirection,
  });

  Future<DataState> updateMilstone({
    required RequestUpdateMilstone requestUpdateMilstone,
  });

  Future<DataState> saveProjectLatest({
    required RequestSaveProjectLatest requestSaveProjectLatest,
  });

  Future<DataState<List<Deliverbles>>> getDeliverables({
    required int pageSize,
    required int skip,
    required String departmentId,
    required int statusId,
    required String assignTo,
    required String searchFilterDefinition,
    required String searchValue,
    required String sortColumnDirection,
    required String columnDirection,
  });

  Future<DataState<Deliverbles>> getDeliverableInfo({
    required String id,
  });

  Future<DataState<List<Milstones.Milstones>>> getProjectMilestones({
    required int pageSize,
    required int skip,
    required String sortColumnDirection,
    required String columnDirection,
  });

  Future<DataState<List<FormApproval>>> getFormsApprovals({
    required int pageSize,
    required int skip,
    required String departmentId,
    required int statusId,
    required String searchFilterDefinition,
    required String searchValue,
    required String sortColumnDirection,
    required String columnDirection,
  });

  Future<DataState<List<TaskUpdateApproval>>> getTaskUpdatesApprovals({
    required int pageSize,
    required int skip,
    required String departmentId,
    required int statusId,
    required String searchFilterDefinition,
    required String searchValue,
    required String sortColumnDirection,
    required String columnDirection,
  });

  Future<DataState<String>> handleFormsApprovals({
    required RequestHandleFormApproval request,
  });

  Future<DataState<String>> handleTaskUpdates({
    required RequestTaskUpdate request,
    required String actionType,
  });

  Future<DataState<List<Strategy>>> getStrategies({
    required bool isMonitoringAndExecution,
    required int pageSize,
    required int skip,
    required String sortColumnDirection,
    required String columnDirection,
  });

  Future<DataState<Strategy>> getStrategyInfo({
    required String id,
  });

  Future<DataState<dynamic>> getTaskUpdates({
    required RequestUpdateTasks requestUpdateTasks,
  });
}
