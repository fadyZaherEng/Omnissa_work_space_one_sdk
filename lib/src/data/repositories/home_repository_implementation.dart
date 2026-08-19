import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/data/sources/remote/mofa/home/entity/remote_current_user_info.dart';
import 'package:mofa/src/data/sources/remote/mofa/home/entity/remote_department.dart';
import 'package:mofa/src/data/sources/remote/mofa/home/entity/remote_home_statistics.dart';
import 'package:mofa/src/data/sources/remote/mofa/home/entity/remote_kpis.dart';
import 'package:mofa/src/data/sources/remote/mofa/home/entity/remote_status.dart';
import 'package:mofa/src/data/sources/remote/mofa/home/home_api_services.dart';
import 'package:mofa/src/data/sources/remote/mofa/mofa_request.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/entities/home/department.dart';
import 'package:mofa/src/domain/entities/home/home_static.dart';
import 'package:mofa/src/domain/entities/home/pointers_tool.dart';
import 'package:mofa/src/domain/entities/home/status_model.dart';
import 'package:mofa/src/domain/entities/home/user_info.dart';
import 'package:mofa/src/domain/repositories/home_repository.dart';
import 'package:mofa/src/domain/usecase/get_language_use_case.dart';
import 'package:mofa/src/domain/usecase/get_token_use_case.dart';
import 'package:mofa/src/domain/usecase/login/get_username_use_case.dart';

class HomeRepositoryImplementation implements HomeRepository {
  final HomeApiServices _homeApiServices;

  HomeRepositoryImplementation(this._homeApiServices);

  @override
  Future<DataState<List<HomeStatistics>>> getStatistics({
    required int pageSize,
    required int skip,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    try {
      MofaRequest request = MofaRequest().createRequest(
        skip: skip,
        pageSize: pageSize,
        searchValue: "",
        searchFilterDefinition: "",
        sortColumnDirection: sortColumnDirection,
        columnDirection: columnDirection,
      );
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _homeApiServices.getStatistics(
        request,
        GetUserNameUseCase(injector())(),
        GetLanguageUseCase(injector())() == "en",
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
  Future<DataState<List<PointersTool>>> getAllKPI({
    required int pageSize,
    required int skip,
    required String sortColumnDirection,
    required String columnDirection,
  }) async {
    try {
      MofaRequest request = MofaRequest().createRequest(
        pageSize: pageSize,
        skip: skip,
        searchValue: "",
        searchFilterDefinition: "",
        sortColumnDirection: sortColumnDirection,
        columnDirection: columnDirection,
      );
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _homeApiServices.getAllKPI(
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
  Future<DataState<List<Department>>> getDepartments() async {
    try {
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _homeApiServices.getDepartments(
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
  Future<DataState<List<StatusModel>>> getStatus() async {
    try {
      String token = GetTokenUseCase(injector())();
      final httpResponse = await _homeApiServices.getRisksIssuesStatus(
        GetLanguageUseCase(injector())() == "en",
        // "Bearer $token",
        GetUserNameUseCase(injector())(),
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
  Future<DataState<CurrentUserInfo>> getCurrentUserInfo() async {
    try {
      final httpResponse = await _homeApiServices.getCurrentUserInfo(
        GetUserNameUseCase(injector())(),
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.data ?? const RemoteCurrentUserInfo())
                .toDomain(),
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
