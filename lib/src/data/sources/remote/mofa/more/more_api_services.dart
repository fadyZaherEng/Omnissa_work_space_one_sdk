import 'package:dio/dio.dart';
import 'package:mofa/src/data/sources/remote/api_key.dart';
import 'package:mofa/src/data/sources/remote/mofa/mofa_request.dart';
import 'package:mofa/src/data/sources/remote/mofa/mofa_response.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remore_milstone_details.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remote_deliverbles.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remote_form_approval.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remote_milstones.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remote_stratygies.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remote_task_board_priority_enum.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remote_task_update_approval.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/entity/remote_tasks.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_save_project_latest.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_task_update.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_update_milstone.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_update_tasks.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_get_all_projects.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_issues.dart';
import 'package:mofa/src/data/sources/remote/mofa/projects/entity/remote_risks.dart';
import 'package:retrofit/retrofit.dart';

part 'more_api_services.g.dart';

@RestApi()
abstract class MoreApiServices {
  factory MoreApiServices(Dio dio) = _MoreApiServices;

  @POST(APIKeys.getAllIssues)
  Future<HttpResponse<MofaResponse<List<RemoteIssues>>>> getIssues(
    @Body() MofaRequest request,
    @Query("useremail") String useremail,
    @Query("IsEnglish") bool isEnglish,
    @Query("projectPriority") int? projectPriority,
    @Query("departmentId") String? departmentId,
    @Query("StatusId") int? statusId,
    @Header("Authorization") String token,
  );

  @GET(APIKeys.getIssueInfo)
  Future<HttpResponse<MofaResponse<RemoteIssues>>> getIssueInfo(
    @Query("useremail") String useremail,
    @Query("IsEnglish") bool isEnglish,
    @Query("id") String id,
    @Header("Authorization") String token,
  );

  @POST(APIKeys.getAllRisks)
  Future<HttpResponse<MofaResponse<List<RemoteRisks>>>> getRisks(
    @Body() MofaRequest request,
    @Query("useremail") String useremail,
    @Query("IsEnglish") bool isEnglish,
    @Query("projectPriority") int? projectPriority,
    @Query("departmentId") String? departmentId,
    @Query("StatusId") int? statusId,
    @Header("Authorization") String token,
  );

  @GET(APIKeys.getRiskInfo)
  Future<HttpResponse<MofaResponse<RemoteRisks>>> getRiskInfo(
    @Query("useremail") String useremail,
    @Query("IsEnglish") bool isEnglish,
    @Query("id") String id,
    @Header("Authorization") String token,
  );

  @POST(APIKeys.updateMilestone)
  Future<HttpResponse> updateMilstone(
    @Query("userEmail") String useremail,
    @Query("isEnglish") bool isEnglish,
    @Header("Authorization") String token,
    @Body() RequestUpdateMilstone requestUpdateMilstone,
  );

  @POST(APIKeys.saveProjectLatestUpdate)
  Future<HttpResponse<MofaResponse>> saveProjectLatestUpdate(
    @Query("userEmail") String useremail,
    @Header("Authorization") String token,
    @Body() RequestSaveProjectLatest requestSaveProjectLatest,
  );

  @POST(APIKeys.getAllProjects)
  Future<HttpResponse<MofaResponse<List<RemoteGetAllProjects>>>> getInitiatives(
    @Body() MofaRequest request,
    @Query("useremail") String useremail,
    @Query("IsEnglish") bool isEnglish,
    @Query("IsInitiative") bool isInitiative,
    @Header("Authorization") String token,
  );

  @POST(APIKeys.getTasks)
  Future<HttpResponse<MofaResponse<List<RemoteTasks>>>> getTasks(
    @Body() MofaRequest request,
    @Query("useremail") String useremail,
    @Query("IsEnglish") bool isEnglish,
    @Header("Authorization") String token,
  );

  @GET(APIKeys.getTaskInfo)
  Future<HttpResponse<MofaResponse<RemoteMilstoneDetails>>> getTaskInfo(
    @Body() MofaRequest request,
    @Query("useremail") String useremail,
    @Query("IsEnglish") bool isEnglish,
    @Query("id") String id,
    @Header("Authorization") String token,
  );

  @POST(APIKeys.getAllDeliverables)
  Future<HttpResponse<MofaResponse<List<RemoteDeliverbles>>>> getDeliverables(
    @Body() MofaRequest request,
    @Query("useremail") String useremail,
    @Query("IsEnglish") bool isEnglish,
    @Query("AssignedTo") String? assignedTo,
    @Query("departmentId") String? departmentId,
    @Query("StatusId") int? statusId,
    @Header("Authorization") String token,
  );

  @GET(APIKeys.getDeliverableInfo)
  Future<HttpResponse<MofaResponse<RemoteDeliverbles>>> getDeliverableInfo(
    @Query("IsEnglish") bool isEnglish,
    @Query("id") String id,
    @Header("Authorization") String token,
  );

  @POST(APIKeys.getFormsApprovals)
  Future<HttpResponse<MofaResponse<List<RemoteFormApproval>>>>
      getFormsApprovals(
    @Body() MofaRequest request,
    @Query("useremail") String useremail,
    @Query("IsEnglish") bool isEnglish,
    @Header("Authorization") String token,
    @Query("departmentId") String? departmentId,
    @Query("StatusId") int? statusId,
  );

  @POST(APIKeys.getTaskUpdates)
  Future<HttpResponse<MofaResponse<List<RemoteTaskUpdateApproval>>>>
      getTaskUpdatesApprovals(
    @Body() MofaRequest request,
    @Query("useremail") String useremail,
    @Query("IsEnglish") bool isEnglish,
    @Header("Authorization") String token,
    @Query("departmentId") String? departmentId,
    @Query("StatusId") int? statusId,
  );

  @POST(APIKeys.getProjectMilestones)
  Future<HttpResponse<MofaResponse<List<RemoteMilstones>>>>
      getProjectMilestones(
    @Body() MofaRequest request,
    @Query("useremail") String useremail,
    @Query("IsEnglish") bool isEnglish,
    @Header("Authorization") String token,
  );

  @MultiPart()
  @POST(APIKeys.handleFormsApprovals)
  Future<HttpResponse<MofaResponse<String>>> handleFormsApprovals(
    @Part(name: "TaskId") String taskId,
    @Part(name: "ActionName") String actionName,
    @Part(name: "Comment") String comment,
    @Query("useremail") String useremail,
    @Query("IsEnglish") bool isEnglish,
  );

  @POST(APIKeys.handleTaskUpdates)
  Future<HttpResponse<MofaResponse<String>>> handleTaskUpdates(
    @Body() List<RequestTaskUpdate> request,
    @Query("useremail") String useremail,
    @Query("IsEnglish") bool isEnglish,
    @Query("actionType") String actionType,
  );

  @POST(APIKeys.getAllStrategies)
  Future<HttpResponse<MofaResponse<List<RemoteStratygies>>>> getStrategies(
    @Body() MofaRequest request,
    @Query("IsEnglish") bool isEnglish,
    @Query("useremail") String useremail,
    @Query("isMonitoringAndExecution") bool isMonitoringAndExecution,
    @Header("Authorization") String token,
  );

  @GET(APIKeys.getStrategyPlanById)
  Future<HttpResponse<MofaResponse<RemoteStratygies>>> getStrategyPlan(
    @Query("IsEnglish") bool isEnglish,
    @Query("useremail") String useremail,
    @Query("Id") String id,
    @Header("Authorization") String token,
  );

  @GET(APIKeys.getTaskboardPriority)
  Future<HttpResponse<MofaResponse<List<RemoteTaskBoardPriorityEnum>>>>
      getTaskboardPriority(
    @Query("IsEnglish") bool isEnglish,
    @Header("Authorization") String token,
  );

  @GET(APIKeys.getTaskboardStatus)
  Future<HttpResponse<MofaResponse<List<RemoteTaskBoardPriorityEnum>>>>
      getTaskboardStatus(
    @Query("IsEnglish") bool isEnglish,
    @Header("Authorization") String token,
  );

  @POST(APIKeys.updateTask)
  Future<HttpResponse<MofaResponse<dynamic>>> getTaskUpdates(
    @Body() RequestUpdateTasks requestUpdateTasks,
    @Query("IsEnglish") bool isEnglish,
    @Query("useremail") String useremail,
    @Header("Authorization") String token,
  );
}
