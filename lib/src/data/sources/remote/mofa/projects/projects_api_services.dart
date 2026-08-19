import 'package:dio/dio.dart';
import 'package:mofa/src/data/sources/remote/api_key.dart';
import 'package:mofa/src/data/sources/remote/mofa/home/entity/remote_department.dart';
import 'package:mofa/src/data/sources/remote/mofa/home/entity/remote_status.dart';
import 'package:mofa/src/data/sources/remote/mofa/mofa_request.dart';
import 'package:mofa/src/data/sources/remote/mofa/mofa_response.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_get_all_projects.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_get_owner.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_project_full_details.dart';
import 'package:retrofit/retrofit.dart';

part 'projects_api_services.g.dart';

@RestApi()
abstract class ProjectsApiServices {
  factory ProjectsApiServices(Dio dio) = _ProjectsApiServices;

  @POST(APIKeys.getAllProjects)
  Future<HttpResponse<MofaResponse<List<RemoteGetAllProjects>>>> getAllProjects(
    @Body() MofaRequest request,
    @Query("useremail") String useremail,
    @Query("IsEnglish") bool isEnglish,
    @Header("Authorization") String token,
    @Query("status") int? status,
    @Query("DepartmentId") String? departmentId,
    @Query("Owner") String? owner,
  );

  @POST(APIKeys.getProjectFullDetails)
  Future<HttpResponse<MofaResponse<RemoteProjectFullDetails>>>
      getProjectFullDetails(
    @Body() MofaRequest request,
    @Query("useremail") String useremail,
    @Query("id") String id,
    @Query("IsEnglish") bool isEnglish,
    @Header("Authorization") String token,
  );

  @GET(APIKeys.getDepartmentsForProject)
  Future<HttpResponse<MofaResponse<List<RemoteDepartment>>>>
      getProjectDepartments(
    @Query("IsEnglish") bool isEnglish,
    @Header("Authorization") String token,
  );

  @GET(APIKeys.getProjectCenterProjects)
  Future<HttpResponse<MofaResponse<List<RemoteStatus>>>>
      getProjectCenterStatusProjects(
    @Query("IsEnglish") bool isEnglish,
    @Header("Authorization") String token,
  );

  @GET(APIKeys.getOwner)
  Future<HttpResponse<MofaResponse<List<RemoteGetOwner>>>> getOwner(
    @Query("IsEnglish") bool isEnglish,
  );
}
