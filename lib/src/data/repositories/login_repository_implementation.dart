import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/data/sources/remote/mofa/login/entity/remote_login.dart';
import 'package:mofa/src/data/sources/remote/mofa/login/login_api_services.dart';
import 'package:mofa/src/data/sources/remote/mofa/login/request/request_login.dart';
import 'package:mofa/src/domain/entities/login/login.dart';
import 'package:mofa/src/domain/repositories/login_repository.dart';

class LoginRepositoryImplementation implements LoginRepository {
  final LoginApiServices _loginApiServices;

  LoginRepositoryImplementation(this._loginApiServices);

  @override
  Future<DataState<Login>> getLogin({
    required RequestLogin requestLogin,
  }) async {
    try {
      final httpResponse = await _loginApiServices.login(
          requestLogin, "application/x-www-form-urlencoded");
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(
          data: httpResponse.data.mapToLogin(),
          message: httpResponse.response.statusMessage ?? "",
        );
      }

      return DataFailed(message: httpResponse.response.statusMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }
}
