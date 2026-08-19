import 'package:mofa/src/di/injector.dart';
import 'package:mofa/src/domain/usecase/home/get_current_user_info_use_case.dart';
import 'package:mofa/src/domain/usecase/home/get_departments_use_case.dart';
import 'package:mofa/src/domain/usecase/home/get_home_statistics_use_case.dart';
import 'package:mofa/src/domain/usecase/home/get_pointers_use_case.dart';
import 'package:mofa/src/domain/usecase/home/get_status_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_challenges_info_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_challenges_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_deliveralbe_info_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_deliveralbes_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_form_approval_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_initiatives_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_milstones_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_risks_info_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_risks_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_stratgies_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_stratgy_info_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_task_info_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_task_priority_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_task_status_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_task_update_approval_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_task_updates_use_case.dart';
import 'package:mofa/src/domain/usecase/more/get_tasks_use_case.dart';
import 'package:mofa/src/domain/usecase/more/handel_task_update_approval_use_case.dart';
import 'package:mofa/src/domain/usecase/more/handle_form_approval_use_case.dart';
import 'package:mofa/src/domain/usecase/more/save_project_latest_use_case.dart';
import 'package:mofa/src/domain/usecase/more/update_milstone_use_case.dart';
import 'package:mofa/src/domain/usecase/projects/get_project_departments_use_case.dart';
import 'package:mofa/src/domain/usecase/projects/get_project_full_details_use_case.dart';
import 'package:mofa/src/domain/usecase/projects/get_project_owner_use_case.dart';
import 'package:mofa/src/domain/usecase/projects/get_project_status_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/challenges_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/change_password_validation_use_case.dart';
import 'package:mofa/src/domain/usecase/get_language_use_case.dart';
import 'package:mofa/src/domain/usecase/get_remember_me_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/deliverables_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/form_approval_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/get_sort_agreement_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/get_sort_challenges_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/get_sort_deliverables_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/get_sort_initiatives_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/get_sort_milstones_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/get_sort_pointers_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/agreements_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/get_token_use_case.dart';
import 'package:mofa/src/domain/usecase/login/get_password_use_case.dart';
import 'package:mofa/src/domain/usecase/login/get_username_use_case.dart';
import 'package:mofa/src/domain/usecase/login/login_use_case.dart';
import 'package:mofa/src/domain/usecase/login/set_password_use_case.dart';
import 'package:mofa/src/domain/usecase/login/set_username_use_case.dart';
import 'package:mofa/src/domain/usecase/get_stratgy_project_use_case.dart';
import 'package:mofa/src/domain/usecase/projects/get_all_projects_use_case.dart';
import 'package:mofa/src/domain/usecase/remove_remember_me_use_case.dart';
import 'package:mofa/src/domain/usecase/set_language_use_case.dart';
import 'package:mofa/src/domain/usecase/set_remember_me_use_case.dart';
import 'package:mofa/src/domain/usecase/set_token_use_case.dart';
import 'package:mofa/src/domain/usecase/sign_in_validation_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/get_sort_project_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/get_sort_risks_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/get_sort_tasks_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/initiatives_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/milstones_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/pointers_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/projects_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/riskss_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_agreement_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_challenges_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_deliverables_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_initiatives_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_milstones_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_pointers_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_project_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_risks_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_strategy_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/set_sort_tasks_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/stratgy_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/task_update_approval_sort_use_case.dart';
import 'package:mofa/src/domain/usecase/sort/tasks_sort_use_case.dart';

Future<void> initializeUseCaseDependencies() async {
  injector.registerFactory<SetLanguageUseCase>(
      () => SetLanguageUseCase(injector()));
  injector.registerFactory<GetLanguageUseCase>(
      () => GetLanguageUseCase(injector()));
  injector.registerFactory<GetRememberMeUseCase>(
      () => GetRememberMeUseCase(injector()));
  injector.registerFactory<RemoveRememberMeUseCase>(
      () => RemoveRememberMeUseCase(injector()));
  injector.registerFactory<SetRememberMeUseCase>(
      () => SetRememberMeUseCase(injector()));
  injector.registerFactory<SignInValidationUseCase>(
      () => SignInValidationUseCase());
  injector.registerFactory<ChangePasswordValidationUseCase>(
      () => ChangePasswordValidationUseCase());
  injector.registerFactory<ProjectsSortUseCase>(() => ProjectsSortUseCase());
  injector.registerFactory<GetSortProjectUseCase>(
      () => GetSortProjectUseCase(injector()));
  injector.registerFactory<SetSortProjectUseCase>(
      () => SetSortProjectUseCase(injector()));
  injector
      .registerFactory<ChallengesSortUseCase>(() => ChallengesSortUseCase());
  injector.registerFactory<GetSortChallengesUseCase>(
      () => GetSortChallengesUseCase(injector()));
  injector.registerFactory<SetSortChallengesUseCase>(
      () => SetSortChallengesUseCase(injector()));
  injector.registerFactory<GetSortPointersUseCase>(
      () => GetSortPointersUseCase(injector()));
  injector.registerFactory<GetSortTasksUseCase>(
      () => GetSortTasksUseCase(injector()));
  injector.registerFactory<SetSortPointersUseCase>(
      () => SetSortPointersUseCase(injector()));
  injector.registerFactory<SetSortTasksUseCase>(
      () => SetSortTasksUseCase(injector()));
  injector.registerFactory<PointersSortUseCase>(() => PointersSortUseCase());
  injector.registerFactory<TasksSortUseCase>(() => TasksSortUseCase());
  injector.registerFactory<SetSortStratgyUseCase>(
      () => SetSortStratgyUseCase(injector()));
  injector.registerFactory<GetSortStrategyUseCase>(
      () => GetSortStrategyUseCase(injector()));
  injector.registerFactory<StratgySortUseCase>(() => StratgySortUseCase());
  injector.registerFactory<SetSortInitiativesUseCase>(
      () => SetSortInitiativesUseCase(injector()));
  injector.registerFactory<GetSortInitiativesUseCase>(
      () => GetSortInitiativesUseCase(injector()));
  injector
      .registerFactory<InitiativesSortUseCase>(() => InitiativesSortUseCase());
  injector.registerFactory<SetSortAgreementUseCase>(
      () => SetSortAgreementUseCase(injector()));
  injector.registerFactory<GetSortAgreementUseCase>(
      () => GetSortAgreementUseCase(injector()));
  injector
      .registerFactory<AgreementsSortUseCase>(() => AgreementsSortUseCase());
  injector.registerFactory<GetTokenUseCase>(() => GetTokenUseCase(injector()));
  injector.registerFactory<SetTokenUseCase>(() => SetTokenUseCase(injector()));
  injector.registerFactory<GetAllProjectsUseCase>(
      () => GetAllProjectsUseCase(injector()));
  injector.registerFactory<LoginUseCase>(() => LoginUseCase(injector()));
  injector.registerFactory<SetUserNameUseCase>(
      () => SetUserNameUseCase(injector()));
  injector.registerFactory<GetPasswordUseCase>(
      () => GetPasswordUseCase(injector()));
  injector.registerFactory<GetUserNameUseCase>(
      () => GetUserNameUseCase(injector()));
  injector.registerFactory<SetPasswordUseCase>(
      () => SetPasswordUseCase(injector()));
  injector.registerFactory<GetHomeStatisticsUseCase>(
      () => GetHomeStatisticsUseCase(injector()));
  injector.registerFactory<GetProjectFullDetailsUseCase>(
      () => GetProjectFullDetailsUseCase(injector()));
  injector.registerFactory<GetRisksUseCase>(() => GetRisksUseCase(injector()));
  injector.registerFactory<GetChallengesInfoUseCase>(
      () => GetChallengesInfoUseCase(injector()));
  injector.registerFactory<GetRisksInfoUseCase>(
      () => GetRisksInfoUseCase(injector()));
  injector.registerFactory<GetChallengesUseCase>(
      () => GetChallengesUseCase(injector()));
  injector.registerFactory<GetInitiativesUseCase>(
      () => GetInitiativesUseCase(injector()));
  injector.registerFactory<GetTasksUseCase>(() => GetTasksUseCase(injector()));
  injector.registerFactory<GetTaskInfoUseCase>(
      () => GetTaskInfoUseCase(injector()));
  injector.registerFactory<GetHomePointersUseCase>(
      () => GetHomePointersUseCase(injector()));
  injector.registerFactory<GetHomeDepartmentsUseCase>(
      () => GetHomeDepartmentsUseCase(injector()));
  injector.registerFactory<GetMilstonesUseCase>(
      () => GetMilstonesUseCase(injector()));
  injector.registerFactory<GetDeliverablesUseCase>(
      () => GetDeliverablesUseCase(injector()));
  injector.registerFactory<GetFormApprovalUseCase>(
      () => GetFormApprovalUseCase(injector()));
  injector.registerFactory<GetTaskUpdateApprovalUseCase>(
      () => GetTaskUpdateApprovalUseCase(injector()));
  injector.registerFactory<GetDeliverableInfoUseCase>(
      () => GetDeliverableInfoUseCase(injector()));
  injector.registerFactory<GetSortDeliverablesUseCase>(
      () => GetSortDeliverablesUseCase(injector()));
  injector.registerFactory<GetSortMilstonesUseCase>(
      () => GetSortMilstonesUseCase(injector()));
  injector.registerFactory<SetSortDeliverablesUseCase>(
      () => SetSortDeliverablesUseCase(injector()));
  injector.registerFactory<SetSortMilstonesUseCase>(
      () => SetSortMilstonesUseCase(injector()));
  injector.registerFactory<DeliverablesSortUseCase>(
      () => DeliverablesSortUseCase());
  injector.registerFactory<MilstonesSortUseCase>(() => MilstonesSortUseCase());
  injector.registerFactory<FormApprovalSortUseCase>(
      () => FormApprovalSortUseCase());
  injector.registerFactory<TaskUpdateApprovalSortUseCase>(
      () => TaskUpdateApprovalSortUseCase());
  injector.registerFactory<HandleFormApprovalUseCase>(
      () => HandleFormApprovalUseCase(injector()));
  injector.registerFactory<HandleTaskUpdateApprovalUseCase>(
      () => HandleTaskUpdateApprovalUseCase(injector()));
  injector.registerFactory<GetStratgyInfoUseCase>(
      () => GetStratgyInfoUseCase(injector()));
  injector.registerFactory<GetStratygiesUseCase>(
      () => GetStratygiesUseCase(injector()));
  injector.registerFactory<GetTaskPriorityUseCase>(
      () => GetTaskPriorityUseCase(injector()));
  injector.registerFactory<GetTaskStatusUseCase>(
      () => GetTaskStatusUseCase(injector()));
  injector.registerFactory<GetTaskUpdatesUseCase>(
      () => GetTaskUpdatesUseCase(injector()));
  injector.registerFactory<GetHomeStatusUseCase>(
      () => GetHomeStatusUseCase(injector()));
  injector.registerFactory<GetProjectDepartmentsUseCase>(
      () => GetProjectDepartmentsUseCase(injector()));
  injector.registerFactory<GetProjectStatusUseCase>(
      () => GetProjectStatusUseCase(injector()));
  injector.registerFactory<RisksSortUseCase>(() => RisksSortUseCase());
  injector.registerFactory<GetSortRisksUseCase>(
      () => GetSortRisksUseCase(injector()));
  injector.registerFactory<SetSortRisksUseCase>(
      () => SetSortRisksUseCase(injector()));
  injector.registerFactory<GetProjectOwnerUseCase>(
      () => GetProjectOwnerUseCase(injector()));
  injector.registerFactory<GetCurrentUserInfoUseCase>(
      () => GetCurrentUserInfoUseCase(injector()));
  injector.registerFactory<UpdateMilstoneUseCase>(
      () => UpdateMilstoneUseCase(injector()));
  injector.registerFactory<SaveProjectLatestUseCase>(
      () => SaveProjectLatestUseCase(injector()));
}
