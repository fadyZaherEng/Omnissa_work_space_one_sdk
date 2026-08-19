import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/extensions/color_extension.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/domain/entities/home/task.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';
import 'package:mofa/src/presentation/widgets/build_header_app_card.dart';
import 'package:mofa/src/presentation/widgets/custom_button_widget.dart';
import 'package:mofa/src/presentation/widgets/progress_horizantal_indicator_widget.dart';

class TaskCardWidget extends StatelessWidget {
  final Task tasks;
  final void Function(Task) onTap;
  final void Function(bool isSubmit, Task) submitBottomSheet;

  const TaskCardWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.submitBottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(tasks),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorSchemes.border, width: 0.75),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            BuildHeaderAppCard(
              title: tasks.name,
              statusColor: tasks.wfStatusColor.color.toColor(),
              status: tasks.wfStatusColor.label.isNotEmpty
                  ? tasks.wfStatusColor.label
                  : S.of(context).notSent,
              id: "",
            ),
            const SizedBox(height: 12),
            Container(height: 0.75, color: ColorSchemes.border),
            const SizedBox(height: 12),
            _buildUserAndDepartment(context),
            const SizedBox(height: 16),
            _buildProjectRow(context),
            const SizedBox(height: 16),
            _buildDatesRow(context),
            const SizedBox(height: 16),
            _buildDatesLineBasicsRow(context),
            const SizedBox(height: 16),
            _buildNumberOfDaysRow(context),
            const SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.all(16),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Expanded(
            //         child: CustomButtonWidget(
            //           onTap: () {
            //             submitBottomSheet(true, tasks);
            //           },
            //           text: S.of(context).submit,
            //           backgroundColor: ColorSchemes.primary,
            //           height: 44,
            //         ),
            //       ),
            //       const SizedBox(width: 32),
            //       Expanded(
            //         child: CustomButtonWidget(
            //           onTap: () {
            //             submitBottomSheet(false, tasks);
            //           },
            //           text: S.of(context).save,
            //           backgroundColor: ColorSchemes.primary,
            //           height: 44,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserAndDepartment(BuildContext context) {
    if (tasks.taskOwnerStr.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildAvatar(context, tasks.taskOwnerStr),
          const SizedBox(width: 8),
          Text(
            tasks.taskOwnerStr,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorSchemes.black,
                  fontWeight: Constants.fontWeightSemiBold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatesRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).taskStartDate,
              value: formatDate(tasks.taskStartDate),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).taskEndDate,
              value: formatDate(tasks.taskEndDate),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).projectName,
              value: tasks.project.projectName,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).projectManager,
              value: tasks.project.projectManagerName,
              // color: ColorSchemes.yellow,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatesLineBasicsRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).startDateBasicsLine,
              value: formatDate(tasks.baselineStartDate.isEmpty
                  ? DateTime.now().toString()
                  : tasks.baselineStartDate),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).endDateBasicsLine,
              value: formatDate(tasks.baselineEndDate.isEmpty
                  ? DateTime.now().toString()
                  : tasks.baselineEndDate),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberOfDaysRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).numberOfDays,
              value: "${tasks.numberOfDays} ${S.of(context).day}",
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildProgressSection(context),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
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
          const SizedBox(height: 8),
          ProgressHorizontalIndicatorWidget(
              status: Status(
            percentage: tasks.draftPercentDone.toDouble() < 10 &&
                    tasks.draftPercentDone.toDouble() > 0
                ? tasks.draftPercentDone.toDouble() + 10
                : tasks.draftPercentDone.toDouble(),
            color: ColorSchemes.primary,
            name: "",
          )),
        ],
      ),
    );
  }

  Widget _buildLabeledValue(
    BuildContext context, {
    required String label,
    required String value,
    Color? color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.gray,
                fontSize: 13,
                fontWeight: Constants.fontWeightSemiBold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: color ?? ColorSchemes.black,
                fontWeight: Constants.fontWeightSemiBold,
              ),
        ),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context, String fullName) {
    final initials = fullName
        .trim()
        .split(' ')
        .where((e) => e.isNotEmpty)
        .map((e) => e.characters.first)
        .take(2)
        .join(' ');

    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ColorSchemes.primary,
      ),
      child: Center(
        child: Text(
          initials,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.white,
                fontSize: 13,
                fontWeight: Constants.fontWeightSemiBold,
              ),
        ),
      ),
    );
  }
}
