import 'package:dio/dio.dart';
import 'package:mofa/src/data/sources/remote/api_key.dart';
import 'package:mofa/src/data/sources/remote/mofa/home/entity/remote_current_user_info.dart';
import 'package:mofa/src/data/sources/remote/mofa/home/entity/remote_department.dart';
import 'package:mofa/src/data/sources/remote/mofa/home/entity/remote_home_statistics.dart';
import 'package:mofa/src/data/sources/remote/mofa/home/entity/remote_kpis.dart';
import 'package:mofa/src/data/sources/remote/mofa/home/entity/remote_status.dart';
import 'package:mofa/src/data/sources/remote/mofa/mofa_request.dart';
import 'package:mofa/src/data/sources/remote/mofa/mofa_response.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_services.g.dart';

@RestApi()
abstract class HomeApiServices {
  factory HomeApiServices(Dio dio) = _HomeApiServices;

  @GET(APIKeys.getStatistics)
  Future<HttpResponse<MofaResponse<List<RemoteHomeStatistics>>>> getStatistics(
    @Body() MofaRequest request,
    @Query("useremail") String useremail,
    @Query("IsEnglish") bool isEnglish,
    @Header("Authorization") String token,
  );

  @POST(APIKeys.getAllKPI)
  Future<HttpResponse<MofaResponse<List<RemoteKpis>>>> getAllKPI(
    @Body() MofaRequest request,
    @Query("useremail") String useremail,
    @Query("IsEnglish") bool isEnglish,
    @Header("Authorization") String token,
  );

  @GET(APIKeys.getDepartments)
  Future<HttpResponse<MofaResponse<List<RemoteDepartment>>>> getDepartments(
    @Query("IsEnglish") bool isEnglish,
    @Header("Authorization") String token,
  );

  @GET(APIKeys.getRisksIssuesStatus)
  Future<HttpResponse<MofaResponse<List<RemoteStatus>>>> getRisksIssuesStatus(
    @Query("isEnglish") bool isEnglish,
    @Query("userEmail") String useremail,
  );

  @GET(APIKeys.getCurrentUserInfo)
  Future<HttpResponse<MofaResponse<RemoteCurrentUserInfo>>> getCurrentUserInfo(
    @Query("useremail") String useremail,
  );
}
