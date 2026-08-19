import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mofa/flavors.dart';
import 'package:mofa/src/core/utils/network/interceptor.dart';
import 'package:mofa/src/data/sources/remote/mofa/home/home_api_services.dart';
import 'package:mofa/src/data/sources/remote/mofa/login/login_api_services.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/more_api_services.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/projects_api_services.dart';
import 'package:mofa/src/domain/usecase/get_token_use_case.dart';
import 'package:mofa/core/services/workspace_one_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final injector = GetIt.instance;

Future<void> initializeDataDependencies() async {
  injector.registerLazySingleton(() => Dio()
    ..options.baseUrl = F.baseUrl
    ..options.headers["Authorization"] =
        "Bearer ${GetTokenUseCase(injector())()}"
    ..options.headers['Content-Type'] = 'application/json'
    ..options.headers['Accept'] = '*/*'
    ..interceptors.add(CustomInterceptors())
    ..interceptors.add(ChuckerDioInterceptor())
    ..interceptors.add(PrettyDioLogger(
      requestHeader: false,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    )));

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  injector.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  injector.registerLazySingleton<ProjectsApiServices>(
      () => ProjectsApiServices(injector()));
  injector.registerLazySingleton<LoginApiServices>(
      () => LoginApiServices(injector()));
  injector.registerLazySingleton<HomeApiServices>(
      () => HomeApiServices(injector()));
  injector.registerLazySingleton<MoreApiServices>(
      () => MoreApiServices(injector()));
  injector.registerLazySingleton<WorkspaceOneService>(
      () => WorkspaceOneService.instance);
}
