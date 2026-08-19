import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/data/sources/remote/mofa/login/request/request_login.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/usecase/login/get_password_use_case.dart';
import 'package:mofa/src/domain/usecase/login/get_username_use_case.dart';
import 'package:mofa/src/domain/usecase/login/login_use_case.dart';
import 'package:mofa/src/domain/usecase/set_token_use_case.dart';
import 'package:flutter/foundation.dart';

import 'package:mofa/core/services/workspace_one_service.dart';

class CustomInterceptors extends InterceptorsWrapper {
  String token = "";

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // جلب رابط السيرفر المخصص من لوحة تحكم Workspace ONE إذا تم تعيينه
    final remoteSettings = await WorkspaceOneService.instance.getCustomSettings();
    if (remoteSettings != null && remoteSettings.isNotEmpty) {
      try {
        final config = jsonDecode(remoteSettings);
        if (config['baseUrl'] != null && config['baseUrl'].toString().isNotEmpty) {
          options.baseUrl = config['baseUrl'].toString();
        }
      } catch (_) {}
    }

    // أضف التوكن لو موجود
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    debugPrint(
      "REQUEST [${options.method}] URL: ${options.baseUrl + options.path} \n"
      "DATA: ${options.data} \n"
      "HEADERS: ${options.headers} \n"
      "QUERY: ${options.queryParameters}",
    );

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    debugPrint(
        "RESPONSE [${response.statusCode}] \n${jsonEncode(response.data)}");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint(
      "ERROR [${err.response?.statusCode}] \n${err.response.toString()} \nHEADERS: ${err.requestOptions.headers}",
    );

    // في حالة 401 نعيد تنفيذ الطلب بعد تجديد التوكن
    if (err.response?.statusCode == 401) {
      try {
        // تنفيذ LoginUseCase لتجديد التوكن
        final login = await LoginUseCase(injector())(
          requestLogin: RequestLogin(
            clientId: Constants.clientId,
            clientSecret: Constants.clientSecret,
            grantType: Constants.grantType,
            scope: Constants.scope,
            password: GetPasswordUseCase(injector())(),
            username: GetUserNameUseCase(injector())(),
          ),
        );

        token = login.data?.accessToken ?? '';
        await SetTokenUseCase(injector())(token);

        // إعادة إعدادات الطلب الأصلي
        final originalRequest = err.requestOptions;
        originalRequest.headers['Authorization'] = 'Bearer $token';

        // إعادة إرسال الطلب باستخدام نفس instance
        final dio = injector<Dio>();
        final response = await dio.fetch(originalRequest);

        return handler.resolve(response); // ✅ نعيد النتيجة للمستدعي
      } catch (e) {
        // لو فشل التجديد أو التنفيذ
        return handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: e,
          type: DioExceptionType.unknown,
        ));
      }
    }

    // في حالة خطأ غير 401
    return super.onError(err, handler);
  }
}
