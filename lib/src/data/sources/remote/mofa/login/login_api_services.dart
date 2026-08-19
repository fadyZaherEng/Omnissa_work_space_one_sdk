import 'package:dio/dio.dart';
import 'package:mofa/src/data/sources/remote/api_key.dart';
import 'package:mofa/src/data/sources/remote/mofa/login/entity/remote_login.dart';
import 'package:mofa/src/data/sources/remote/mofa/login/request/request_login.dart';
import 'package:retrofit/retrofit.dart';

part 'login_api_services.g.dart';

@RestApi()
abstract class LoginApiServices {
  factory LoginApiServices(Dio dio) = _LoginApiServices;

  @POST(APIKeys.login)
  Future<HttpResponse<RemoteLogin>> login(
    @Body() RequestLogin request,
    @Header("Content-Type") String contentType,
  );
}
