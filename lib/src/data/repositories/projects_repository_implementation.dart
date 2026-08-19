import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/data/sources/remote/mofa/home/entity/remote_department.dart';
import 'package:mofa/src/data/sources/remote/mofa/home/entity/remote_status.dart';
import 'package:mofa/src/data/sources/remote/mofa/mofa_request.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_get_all_projects.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_get_owner.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_project_full_details.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/projects_api_services.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/entities/home/department.dart';
import 'package:mofa/src/domain/entities/home/owner.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/home/project_details.dart';
import 'package:mofa/src/domain/entities/home/status_model.dart';
import 'package:mofa/src/domain/repositories/get_all_projects_repository.dart';
import 'package:mofa/src/domain/usecase/get_language_use_case.dart';
import 'package:mofa/src/domain/usecase/get_token_use_case.dart';
import 'package:mofa/src/domain/usecase/login/get_username_use_case.dart';

class GetAllProjectsRepositoryImplementation
    implements GetAllProjectsRepository {
  final ProjectsApiServices _projectsApiServices;

  GetAllProjectsRepositoryImplementation(this._projectsApiServices);

  @override
  Future<DataState<List<Project>>> getAllProjects({
    required int pageSize,
    required int skip,
    required int status,
    required String departmentId,
    required String owner,
    required String searchValue,
    required String searchFilterDefinition,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    try {
      MofaRequest request = MofaRequest().createRequest(
        skip: skip,
        pageSize: pageSize,
        searchValue: searchValue,
        searchFilterDefinition: searchFilterDefinition,
        sortColumnDirection: sortColumnDirection,
        columnDirection: columnDirection,
      );
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _projectsApiServices.getAllProjects(
        request,
        GetUserNameUseCase(injector())(),
        GetLanguageUseCase(injector())() == "en",
        "Bearer $token",
        status == -1 ? null : status,
        departmentId == "" ? null : departmentId,
        owner == "" ? null : owner,
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
  Future<DataState<ProjectDetails>> getProjectFullDetials({
    required String projectId,
    required String searchValue,
    required String draw,
    required int pageSize,
    required int skip,
  }) async {
    try {
      MofaRequest request = MofaRequest().createRequest(
        pageSize: pageSize,
        skip: skip,
        searchFilterDefinition: "",
        searchValue: searchValue,
        sortColumnDirection: "desc",
        columnDirection: "descending",
        draw: draw,
      );
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _projectsApiServices.getProjectFullDetails(
        request,
        GetUserNameUseCase(injector())(),
        projectId,
        GetLanguageUseCase(injector())() == "en",
        "Bearer $token",
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.data ?? const RemoteProjectFullDetails())
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
  Future<DataState<List<Department>>> getProjectDepartments() async {
    try {
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _projectsApiServices.getProjectDepartments(
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
  Future<DataState<List<StatusModel>>> getProjectStatus() async {
    try {
      String token = GetTokenUseCase(injector())();
      final httpResponse =
          await _projectsApiServices.getProjectCenterStatusProjects(
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
  Future<DataState<List<GetOwner>>> getProjectOwners() async {
    try {
      final httpResponse = await _projectsApiServices.getOwner(
        GetLanguageUseCase(injector())() == "en",
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
}
