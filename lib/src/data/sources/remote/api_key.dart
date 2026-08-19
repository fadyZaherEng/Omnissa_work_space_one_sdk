class APIKeys {
  //BASE_URL
  static const String baseUrlDevelopment =
      "https://mofa-api.transitiondemo.com/api/";
  static const String baseUrlProduction =
      "https://munjezapp.mofa.gov.sa/";

  //LOGIN
  static const String login =
      "https://login.microsoftonline.com/ce69d0a5-3ace-44e9-a829-a7347d06953a//oauth2/v2.0/token";

  //HOME
  static const String getStatistics = "Home/GetStatisctics";
  static const String getAllProjects =
      "Projects/GetAllProjects"; //for project and  initiative
  static const String getProjectFullDetails =
      "Projects/GetProjectFullDetails"; //for project details and  initiative details

  //more
  static const String getAllIssues = "ProjectIssues/GetAllIssues";
  static const String getIssueInfo = "ProjectIssues/GetIssueInfo";
  static const String getAllRisks = "ProjectRisks/GetAllRisks";
  static const String getRiskInfo = "ProjectRisks/GetRiskInfo";
  static const String getTasks = "Scheduler/GetTasks";
  static const String getTaskInfo = "Scheduler/GetTaskInfoById";
  static const String getAllKPI = "MyKPI/GetAllKPIs";
  static const String getTaskUpdates = "Approval/GetTaskUpdatesApprovals";
  static const String getFormsApprovals = "Approval/GetFormsApprovals";
  static const String getProjectMilestones = "Scheduler/GetAllMilestones";
  static const String getDeliverableInfo =
      "ProjectDeliverables/GetDeliverableInfo";
  static const String getAllDeliverables =
      "ProjectDeliverables/GetAllDeliverables";
  static const String handleTaskUpdates = "Approval/HandleTaskUpdatesApprovals";
  static const String handleFormsApprovals = "Approval/HandleFormsApprovals";
  static const String getAllStrategies = "Strategy/GetAllStrategies";
  static const String getStrategyPlanById = "Strategy/GetStrategyPlanById";
  static const String getTaskboardStatus = "General/GetTaskboardStatusEnum";
  static const String getTaskboardPriority = "General/GetTaskboardPriorityEnum";
  static const String updateTask = "Scheduler/UpdateTask";

  //filter project
  static const String getProjectCenterProjects =
      "General/GetProjectCenterProjectsStatus";
  static const String getDepartmentsForProject =
      "General/GetDepartmentsForProjectFilter";

  //General Filter
  static const String getDepartments = "General/GetAllDepartment";
  static const String getRisksIssuesStatus = "General/GetRisksIssuesStatus";
  static const String getOwner = "General/GetOwner";
  static const String getCurrentUserInfo = "general/GetCurrentUserInfo";
  static const String updateMilestone = "Scheduler/UpdateMilestone";
  static const String saveProjectLatestUpdate =
      "Projects/SaveProjectLatestUpdate";
}
