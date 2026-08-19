import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/data/sources/remote/mofa/more/request/request_update_tasks.dart';
import 'package:mofa/src/domain/entities/home/task_enum.dart';
import 'package:mofa/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:mofa/src/presentation/widgets/task_updates_bottom_sheet_widget.dart';

Future showTaskUpdatesBottomSheet({
  required BuildContext context,
  double? height,
  required List<TaskBoardEnum> taskStatus,
  required List<TaskBoardEnum> taskPriority,
  required String taskId,
  required String taskAssigneeId,
  required bool isSubmit,
  required bool showDuration,
  required bool showPriority,
  required Function(RequestUpdateTasks) onConfirm,
}) async {
  return await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 8,
        left: 8,
        right: 8,
      ),
      child: BottomSheetWidget(
        titleLabel: S.of(context).taskUpdates,
        height: height ?? MediaQuery.of(context).size.height * 0.7,
        content: TaskUpdatesBottomSheetWidget(
          taskStatus: taskStatus,
          taskPriority: taskPriority,
          taskId: taskId,
          taskAssigneeId: taskAssigneeId,
          onConfirm: onConfirm,
          isSubmit: isSubmit,
          showDuration: showDuration,
          showPriority: showPriority,
        ),
      ),
    ),
  );
}
