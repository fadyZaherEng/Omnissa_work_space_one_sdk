import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/utils/show_Task_updates_bottom_sheet.dart';
import 'package:mofa/src/core/utils/show_massage_dialog_widget.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_update_tasks.dart';
import 'package:mofa/src/domain/entities/home/task.dart';
import 'package:mofa/src/domain/entities/home/task_enum.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';
import 'package:mofa/src/presentation/screens/home/home_screen.dart';
import 'package:mofa/src/presentation/screens/tasks/skeleton/task_details_skeleton.dart';
import 'package:mofa/src/presentation/widgets/bell_notification_widget.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/presentation/blocs/tasks/tasks_bloc.dart';
import 'package:mofa/src/presentation/widgets/custom_button_widget.dart';
import 'package:mofa/src/presentation/widgets/progress_horizantal_indicator_widget.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;
  final List<TaskBoardEnum> taskStatus;

  const TaskDetailsScreen({
    super.key,
    required this.task,
    required this.taskStatus,
  });

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController _commentController;
  final bool _isSubmitting = false;
  Task task = const Task();

  @override
  void initState() {
    _commentController = TextEditingController();
    task = widget.task;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TaskDetailsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    task = widget.task;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksState>(
      listener: (context, state) {
        // if (state is TaskUpdatesSuccessState) {
        //   _showMessageDialog(
        //     message: state.message,
        //     icon: ImagePaths.success,
        //   );
        // } else if (state is TaskUpdatesErrorState) {
        //   _showMessageDialog(
        //     message: state.errorMessage,
        //     icon: ImagePaths.warning,
        //   );
        // }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBarWidget(
            context,
            title: S.of(context).taskDetails,
            isHaveBackButton: true,
            onBackButtonPressed: () => Navigator.of(context).pop(),
            centredTitle: true,
            actionWidget: BellNotificationWidget(
              totalApprovals: totalApprovals,
            ),
          ),
          body: state is GetTaskInfoLoadingState
              ? const TaskDetailsSkeleton()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 8),
                            Text(
                              S.of(context).taskInfo,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: ColorSchemes.black,
                                    fontWeight: Constants.fontWeightSemiBold,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _buildTaskInfoSection(),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const SizedBox(width: 8),
                            Text(
                              S.of(context).taskUpdate,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: ColorSchemes.black,
                                    fontWeight: Constants.fontWeightSemiBold,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _buildAssignmentInfoSection(),
                        const SizedBox(height: 8),
                        _buildActionButtons(),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildTaskInfoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 4,
        color: ColorSchemes.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: ColorSchemes.white,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildReadOnlyField(
                      label: S.of(context).taskName,
                      value: task.name,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildReadOnlyField(
                      label: S.of(context).projectName,
                      value: task.project.projectName,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildReadOnlyField(
                label: S.of(context).projectManager,
                value: task.project.projectManagerName,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildReadOnlyField(
                      label: S.of(context).startDate,
                      value: formatDate(task.taskStartDate),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildReadOnlyField(
                      label: S.of(context).endDate,
                      value: formatDate(task.taskEndDate),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildReadOnlyField(
                      label: S.of(context).priority,
                      value: task.taskPriorityStr,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildReadOnlyField(
                      label: S.of(context).status,
                      value: task.taskStatusStr,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).achievement,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorSchemes.gray,
                          fontSize: 13,
                          fontWeight: Constants.fontWeightSemiBold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  ProgressHorizontalIndicatorWidget(
                    status: Status(
                      percentage: task.percentDone.toDouble() < 10 &&
                              task.percentDone.toDouble() > 0
                          ? task.percentDone.toDouble() + 10
                          : task.percentDone.toDouble(),
                      color: Colors.green,
                      name: "",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMessageDialog({
    required String message,
    required String icon,
  }) {
    showMassageDialogWidget(
      context: context,
      text: message,
      icon: icon,
      buttonText: S.of(context).ok,
      onTap: () => Navigator.pop(context),
    );
  }

  Widget _buildAssignmentInfoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 4,
        color: ColorSchemes.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: ColorSchemes.white,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).status,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorSchemes.gray,
                                    fontWeight: Constants.fontWeightSemiBold,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          task.draftStatusObject.label,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorSchemes.black,
                                    fontWeight: Constants.fontWeightBold,
                                  ),
                        ),
                        // StatusWidget(
                        //   statusColor: task.draftStatusObject.color.toColor(),
                        //   statusMessage: task.draftStatusObject.label,
                        //   isProject: false,
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildReadOnlyField(
                      label: S.of(context).creationDate,
                      value: formatDate(task.taskStartDate),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildProgressSection(context),
              const SizedBox(height: 16),
              //comment section
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  S.of(context).comment,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.gray,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
              ),
              Text(
                task.comment.isEmpty ? "----" : task.comment,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.black,
                      fontWeight: Constants.fontWeightSemiBold,
                    ),
              ),
              // const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).achievement,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.gray,
                fontSize: 13,
                fontWeight: Constants.fontWeightSemiBold,
              ),
        ),
        const SizedBox(height: 4),
        ProgressHorizontalIndicatorWidget(
          status: Status(
            percentage: task.draftPercentDone.toDouble() < 10 &&
                    task.draftPercentDone.toDouble() > 0
                ? task.draftPercentDone.toDouble() + 10
                : task.draftPercentDone.toDouble(),
            color: Colors.green,
            name: "",
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomButtonWidget(
              onTap: () => Navigator.pop(context),
              text: S.of(context).cancel,
              height: 46,
              backgroundColor: ColorSchemes.gray,
              textColor: ColorSchemes.black,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CustomButtonWidget(
              onTap: _submitTaskUpdate,
              text: S.of(context).submit,
              height: 46,
              backgroundColor: ColorSchemes.primary,
              isLoading: _isSubmitting,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadOnlyField({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.gray,
                fontWeight: Constants.fontWeightSemiBold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.black,
                fontWeight: Constants.fontWeightBold,
              ),
        ),
      ],
    );
  }

  void _submitTaskUpdate() {
    if (task.wfStatusColor.label == "Submitted" ||
        task.wfStatusColor.label == "مرسلة") {
      _showResubmissionConfirmation();
    } else {
      _submitToServer();
    }
  }

  void _showResubmissionConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).confirmResubmission),
        content: Text(S.of(context).resubmitTaskWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              S.of(context).cancel,
              style: const TextStyle(
                color: ColorSchemes.gray,
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _submitToServer();
            },
            child: Text(
              S.of(context).confirm,
              style: const TextStyle(
                color: ColorSchemes.primary,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TasksBloc get _bloc => context.read<TasksBloc>();

  void _submitToServer() {
    showTaskUpdatesBottomSheet(
      context: context,
      taskStatus: widget.taskStatus,
      taskPriority: [],
      showDuration: false,
      showPriority: false,
      taskId: task.id,
      height: MediaQuery.of(context).size.height * 0.62,
      taskAssigneeId: task.assignmentId,
      isSubmit: task.isOperationalTask,
      onConfirm: (RequestUpdateTasks requestUpdateTasks) {
        _bloc.add(
          TaskUpdateEvent(
            requestUpdateTasks: requestUpdateTasks,
            skip: 0,
            pageSize: 10,
          ),
        );
        Navigator.pop(context);
      },
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
