import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/data/sources/remote/mofa/mofa_request.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remore_milstone_details.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remote_deliverbles.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remote_form_approval.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remote_stratygies.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remote_task_board_priority_enum.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remote_task_update_approval.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remote_milstones.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remote_tasks.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/more_api_services.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_handle_form_approval.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_save_project_latest.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_task_update.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_update_milstone.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_update_tasks.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_get_all_projects.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_issues.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_risks.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
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
import 'package:mofa/src/domain/repositories/more_repository.dart';
import 'package:mofa/src/domain/usecase/get_language_use_case.dart';
import 'package:mofa/src/domain/usecase/get_token_use_case.dart';
import 'package:mofa/src/domain/usecase/login/get_username_use_case.dart';

class MoreRepositoryImplementation implements MoreRepository {
  final MoreApiServices _moreApiServices;

  MoreRepositoryImplementation(this._moreApiServices);

  @override
  Future<DataState<Challenges>> getIssueInfo({required String id}) async {
    try {
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.getIssueInfo(
        GetUserNameUseCase(injector())(),
        GetLanguageUseCase(injector())() == "en",
        id,
        "Bearer $token",
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data:
                (httpResponse.data.data ?? const RemoteIssues()).mapToDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
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
  }) async {
    try {
      MofaRequest request = MofaRequest().createRequest(
        pageSize: pageSize,
        skip: skip,
        searchFilterDefinition: searchFilterDefinition,
        searchValue: searchValue,
        sortColumnDirection: sortColumnDirection,
        columnDirection: columnDirection,
      );
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.getIssues(
        request,
        GetUserNameUseCase(injector())(),
        GetLanguageUseCase(injector())() == "en",
        priorityId == -1 ? null : priorityId,
        departmentId.isNotEmpty ? departmentId : null,
        statusId == -1 ? null : statusId,
        "Bearer $token",
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.data ?? []).mapToDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<Risks>> getRiskInfo({required String id}) async {
    try {
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.getRiskInfo(
        GetUserNameUseCase(injector())(),
        GetLanguageUseCase(injector())() == "en",
        id,
        "Bearer $token",
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.data ?? const RemoteRisks()).mapToDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
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
  }) async {
    try {
      MofaRequest request = MofaRequest().createRequest(
        skip: skip,
        pageSize: pageSize,
        searchFilterDefinition: searchFilterDefinition,
        searchValue: searchValue,
        sortColumnDirection: sortColumnDirection,
        columnDirection: columnDirection,
      );
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.getRisks(
        request,
        GetUserNameUseCase(injector())(),
        GetLanguageUseCase(injector())() == "en",
        priorityId == -1 ? null : priorityId,
        departmentId.isNotEmpty ? departmentId : null,
        statusId == -1 ? null : statusId,
        "Bearer $token",
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.data ?? []).mapToDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<List<Project>>> getInitiatives({
    required int pageSize,
    required int skip,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    try {
      MofaRequest request = MofaRequest().createRequest(
        pageSize: pageSize,
        skip: skip,
        searchFilterDefinition: "",
        searchValue: "",
        sortColumnDirection: sortColumnDirection,
        columnDirection: columnDirection,
      );
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.getInitiatives(
        request,
        GetUserNameUseCase(injector())(),
        GetLanguageUseCase(injector())() == "en",
        true,
        "Bearer $token",
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.data ?? []).mapToDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<List<Task>>> getTasks({
    required int pageSize,
    required int skip,
    required String searchValue,
    required String searchFilterDefinition,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    try {
      MofaRequest request = MofaRequest().createRequest(
        skip: skip,
        pageSize: pageSize,
        searchFilterDefinition: searchFilterDefinition,
        searchValue: searchValue,
        sortColumnDirection: sortColumnDirection,
        columnDirection: columnDirection,
      );
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.getTasks(
        request,
        GetUserNameUseCase(injector())(),
        GetLanguageUseCase(injector())() == "en",
        "Bearer $token",
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.data ?? []).toDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<RemoteMilstoneDetails>> getTaskInfo({
    required String id,
    required int pageSize,
    required int skip,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    try {
      MofaRequest request = MofaRequest().createRequest(
        pageSize: pageSize,
        skip: skip,
        searchFilterDefinition: "",
        searchValue: "",
        sortColumnDirection: sortColumnDirection,
        columnDirection: columnDirection,
      );
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.getTaskInfo(
        request,
        GetUserNameUseCase(injector())(),
        GetLanguageUseCase(injector())() == "en",
        id,
        "Bearer $token",
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: httpResponse.data.data,
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<Deliverbles>> getDeliverableInfo(
      {required String id}) async {
    try {
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.getDeliverableInfo(
        GetLanguageUseCase(injector())() == "en",
        id,
        "Bearer $token",
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.data ?? const RemoteDeliverbles())
                .mapToDeliverbles(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
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
  }) async {
    try {
      MofaRequest request = MofaRequest().createRequest(
        skip: skip,
        pageSize: pageSize,
        searchFilterDefinition: searchFilterDefinition,
        searchValue: searchValue,
        sortColumnDirection: sortColumnDirection,
        columnDirection: columnDirection,
      );
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.getDeliverables(
        request,
        GetUserNameUseCase(injector())(),
        GetLanguageUseCase(injector())() == "en",
        assignTo.isNotEmpty ? assignTo : null,
        departmentId.isNotEmpty ? departmentId : null,
        statusId == -1 ? null : statusId,
        "Bearer $token",
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.data ?? []).mapToDeliverbles(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<List<FormApproval>>> getFormsApprovals({
    required int pageSize,
    required int skip,
    required String departmentId,
    required int statusId,
    required String searchFilterDefinition,
    required String searchValue,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    try {
      MofaRequest request = MofaRequest().createRequest(
        pageSize: pageSize,
        skip: skip,
        searchValue: searchValue,
        searchFilterDefinition: searchFilterDefinition,
        sortColumnDirection: sortColumnDirection,
        columnDirection: columnDirection,
      );
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.getFormsApprovals(
        request,
        GetUserNameUseCase(injector())(),
        GetLanguageUseCase(injector())() == "en",
        "Bearer $token",
        departmentId.isNotEmpty ? departmentId : null,
        statusId == -1 ? null : statusId,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.data ?? []).mapToDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<List<Milstones.Milstones>>> getProjectMilestones({
    required int pageSize,
    required int skip,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    try {
      MofaRequest request = MofaRequest().createRequest(
        skip: skip,
        pageSize: pageSize,
        searchFilterDefinition: "",
        searchValue: "",
        sortColumnDirection: sortColumnDirection,
        columnDirection: columnDirection,
      );
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.getProjectMilestones(
        request,
        GetUserNameUseCase(injector())(),
        GetLanguageUseCase(injector())() == "en",
        "Bearer $token",
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.data ?? []).toDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<List<TaskUpdateApproval>>> getTaskUpdatesApprovals({
    required int pageSize,
    required int skip,
    required String departmentId,
    required int statusId,
    required String searchFilterDefinition,
    required String searchValue,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    try {
      MofaRequest request = MofaRequest().createRequest(
        pageSize: pageSize,
        skip: skip,
        searchValue: searchValue,
        searchFilterDefinition: searchFilterDefinition,
        columnDirection: columnDirection,
        sortColumnDirection: sortColumnDirection,
      );
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.getTaskUpdatesApprovals(
        request,
        GetUserNameUseCase(injector())(),
        GetLanguageUseCase(injector())() == "en",
        "Bearer $token",
        departmentId.isNotEmpty ? departmentId : null,
        statusId == -1 ? null : statusId,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.data ?? []).mapToDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<String>> handleFormsApprovals({
    required RequestHandleFormApproval request,
  }) async {
    try {
      final httpResponse = await _moreApiServices.handleFormsApprovals(
        request.TaskId.toString(),
        request.ActionName.toString(),
        request.Comment.toString(),
        GetUserNameUseCase(injector())(),
        GetLanguageUseCase(injector())() == "en",
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: httpResponse.data.data ?? "",
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.error ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<String>> handleTaskUpdates({
    required RequestTaskUpdate request,
    required String actionType,
  }) async {
    try {
      final httpResponse = await _moreApiServices.handleTaskUpdates(
        [request],
        GetUserNameUseCase(injector())(),
        GetLanguageUseCase(injector())() == "en",
        actionType,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: httpResponse.data.data ?? "",
            message: httpResponse.data.responseMessage == null ||
                    httpResponse.data.responseMessage == ""
                ? S.current.success
                : httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<List<Strategy>>> getStrategies({
    required bool isMonitoringAndExecution,
    required int pageSize,
    required int skip,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    try {
      MofaRequest request = MofaRequest().createRequest(
        skip: skip,
        pageSize: pageSize,
        searchFilterDefinition: "",
        searchValue: "",
        sortColumnDirection: sortColumnDirection,
        columnDirection: columnDirection,
      );
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.getStrategies(
        request,
        GetLanguageUseCase(injector())() == "en",
        GetUserNameUseCase(injector())(),
        isMonitoringAndExecution,
        "Bearer $token",
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.data ?? []).mapToDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<Strategy>> getStrategyInfo({required String id}) async {
    try {
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.getStrategyPlan(
        GetLanguageUseCase(injector())() == "en",
        GetUserNameUseCase(injector())(),
        id,
        "Bearer $token",
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.data ?? const RemoteStratygies())
                .mapToDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<List<TaskBoardEnum>>> getTaskboardPriority() async {
    try {
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.getTaskboardPriority(
        GetLanguageUseCase(injector())() == "en",
        "Bearer $token",
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.data ?? const []).mapToDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<List<TaskBoardEnum>>> getTaskboardStatus() async {
    try {
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.getTaskboardStatus(
        GetLanguageUseCase(injector())() == "en",
        "Bearer $token",
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.data ?? const []).mapToDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<dynamic>> getTaskUpdates({
    required RequestUpdateTasks requestUpdateTasks,
  }) async {
    try {
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.getTaskUpdates(
        requestUpdateTasks,
        GetLanguageUseCase(injector())() == "en",
        GetUserNameUseCase(injector())(),
        "Bearer $token",
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.error ?? ""),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState> updateMilstone({
    required RequestUpdateMilstone requestUpdateMilstone,
  }) async {
    try {
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.updateMilstone(
        GetUserNameUseCase(injector())(),
        GetLanguageUseCase(injector())() == "en",
        "Bearer $token",
        requestUpdateMilstone,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState> saveProjectLatest(
      {required RequestSaveProjectLatest requestSaveProjectLatest}) async {
    try {
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _moreApiServices.saveProjectLatestUpdate(
        GetUserNameUseCase(injector())(),
        "Bearer $token",
        requestSaveProjectLatest,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.error ?? ""),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }

      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }
}
