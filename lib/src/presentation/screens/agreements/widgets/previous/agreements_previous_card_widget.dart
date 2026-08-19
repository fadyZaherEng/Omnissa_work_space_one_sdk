import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/domain/entities/home/task_update_approval.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';
import 'package:mofa/src/presentation/widgets/custom_button_with_prefix_icon_widget.dart';
import 'package:mofa/src/presentation/widgets/progress_horizantal_indicator_widget.dart';

class AgreementsPreviousCardWidget extends StatelessWidget {
  final TaskUpdateApproval agreement;
  final void Function(TaskUpdateApproval) onTap;
  final void Function(TaskUpdateApproval) onAcceptTap;
  final void Function(TaskUpdateApproval) onDeclineTap;

  const AgreementsPreviousCardWidget({
    super.key,
    required this.agreement,
    required this.onTap,
    required this.onAcceptTap,
    required this.onDeclineTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(agreement),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorSchemes.border, width: 0.75),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).taskInfo,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.black,
                      fontWeight: Constants.fontWeightSemiBold,
                    ),
              ),
              _buildTaskInfoSection(context),
              const SizedBox(height: 16),
              Text(
                S.of(context).taskUpdate,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.black,
                      fontWeight: Constants.fontWeightSemiBold,
                    ),
              ),
              const SizedBox(height: 16),
              _buildAssignmentInfoSection(context),
              // const SizedBox(height: 24),
              // BuildHeaderAppCard(
              //   title: agreement.projectName,
              //   statusColor: ColorSchemes.primary,
              //   status: agreement.taskStatusStr,
              //   id: "",
              // ),
              // const SizedBox(height: 12),
              // Container(height: 0.75, color: ColorSchemes.border),
              // const SizedBox(height: 12),
              // BuildUserAndDepartmentCardWidget(
              //   name: agreement.taskName,
              //   label: S.of(context).creationDate,
              //   value: formatDate(agreement.creationDate.isEmpty
              //       ? DateTime.now().toString()
              //       : agreement.creationDate),
              // ),
              const SizedBox(height: 12),
              Container(height: 0.75, color: ColorSchemes.border),
              const SizedBox(height: 12),
              _buildButtonsOptions(context),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskInfoSection(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildReadOnlyField(
                  label: S.of(context).taskName,
                  value: agreement.taskName,
                  context: context,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildReadOnlyField(
                  label: S.of(context).projectName,
                  value: agreement.projectName,
                  context: context,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildReadOnlyField(
            label: S.of(context).projectManager,
            value: agreement.projectManager,
            context: context,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildReadOnlyField(
                  label: S.of(context).startDate,
                  value: formatDate(agreement.taskStartDate),
                  context: context,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildReadOnlyField(
                  label: S.of(context).endDate,
                  value: formatDate(agreement.taskEndDate),
                  context: context,
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
                  value: agreement.taskPriorityStr,
                  context: context,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildReadOnlyField(
                  label: S.of(context).status,
                  value: agreement.taskStatusStr,
                  context: context,
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
                S.of(context).taskPercentDone,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.gray,
                      fontSize: 13,
                      fontWeight: Constants.fontWeightSemiBold,
                    ),
              ),
              const SizedBox(height: 8),
              ProgressHorizontalIndicatorWidget(
                status: Status(
                  percentage: double.parse(
                                  agreement.taskpercentDone.toString()) <
                              10 &&
                          double.parse(agreement.taskpercentDone.toString()) > 0
                      ? double.parse(agreement.taskpercentDone.toString()) + 10
                      : double.parse(agreement.taskpercentDone.toString()),
                  color: Colors.green,
                  name: "",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentInfoSection(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorSchemes.gray,
                            fontWeight: Constants.fontWeightSemiBold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      agreement.assignmentStatusStr,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorSchemes.black,
                            fontWeight: Constants.fontWeightBold,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildReadOnlyField(
                  label: S.of(context).creationDate,
                  value: formatDate(agreement.creationDate),
                  context: context,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildProgressSection(context)),
              const SizedBox(width: 16),
              Expanded(
                child: _buildReadOnlyField(
                  label: S.of(context).createdBy,
                  value: agreement.createdBy,
                  context: context,
                ),
              ),
            ],
          ),
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
            agreement.assignmentComments.isEmpty
                ? "----"
                : agreement.assignmentComments,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorSchemes.black,
                  fontWeight: Constants.fontWeightSemiBold,
                ),
          ),
          // const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).assignmentPercentDone,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.gray,
                fontSize: 13,
                fontWeight: Constants.fontWeightSemiBold,
              ),
        ),
        const SizedBox(height: 4),
        ProgressHorizontalIndicatorWidget(
          status: Status(
            percentage: double.parse(
                            agreement.assignmentpercentDone.toString()) <
                        10 &&
                    double.parse(agreement.assignmentpercentDone.toString()) > 0
                ? double.parse(agreement.assignmentpercentDone.toString()) + 10
                : double.parse(agreement.assignmentpercentDone.toString()),
            color: Colors.green,
            name: "",
          ),
        ),
      ],
    );
  }

  Widget _buildReadOnlyField({
    required String label,
    required String value,
    required BuildContext context,
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

  Widget _buildButtonsOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomButtonWithPrefixIconWidget(
              onTap: () => onAcceptTap(agreement),
              text: S.of(context).accept,
              backgroundColor: ColorSchemes.primary,
              svgIcon: ImagePaths.approveNew,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CustomButtonWithPrefixIconWidget(
              onTap: () => onDeclineTap(agreement),
              text: S.of(context).decline,
              backgroundColor: ColorSchemes.secondary,
              svgIcon: ImagePaths.cancelDelete,
              iconColor: ColorSchemes.red,
              textColor: ColorSchemes.gray,
            ),
          )
        ],
      ),
    );
  }
}
