import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/extensions/color_extension.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/domain/entities/home/challenges.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';
import 'package:mofa/src/presentation/widgets/build_header_app_card.dart';
import 'package:mofa/src/presentation/widgets/build_user_and_department_card_widget.dart';
import 'package:mofa/src/presentation/widgets/status_widget.dart';

class ChallengeCardWidget extends StatelessWidget {
  final Challenges challenge;
  final void Function(Challenges) onTap;

  const ChallengeCardWidget({
    super.key,
    required this.challenge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(challenge),
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
              title: challenge.title,
              statusColor: challenge.statusColor.color.toColor(),
              status: challenge.statusColor.label,
              id: "",
              isPriority: true,
              priorityStatusColor: challenge.issuePrioColor,
              showStatus: false,
            ),
            const SizedBox(height: 12),
            Container(height: 0.75, color: ColorSchemes.border),
            const SizedBox(height: 12),
            BuildUserAndDepartmentCardWidget(
              name: challenge.projectName,
              label: S.of(context).projectManager,
              value: challenge.projectManagerStr,
              isRisk: true,
            ),
            const SizedBox(height: 12),
            // BuildUserAndDepartmentCardWidget(
            //   name: challenge.projectManagerStr,
            //   isRisk: false,
            //   label: S.of(context).assignTo,
            //   value: challenge.assignedTo,
            // ),
            //  const SizedBox(height: 8),
            if (challenge.address.isNotEmpty) _buildAddressRow(context),
            if (challenge.address.isNotEmpty) const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (challenge.severityOfTheChallenge.name.isNotEmpty)
                    _buildLabeledValue(
                      context,
                      label: S.of(context).severityOfTheChallenge,
                      value: challenge.severityOfTheChallenge,
                    ),
                  const SizedBox(width: 16),
                  const Spacer(),
                  if (challenge.workflowCases.name.isNotEmpty)
                    Expanded(
                      flex: 2,
                      child: _buildLabeledValue(
                        context,
                        label: S.of(context).workflowCases,
                        value: challenge.workflowCases,
                        isSpacer: true,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).assignTo,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorSchemes.gray,
                                    fontSize: 13,
                                    fontWeight: Constants.fontWeightSemiBold,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          challenge.assignedTo,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorSchemes.black,
                                    fontSize: 13,
                                    fontWeight: Constants.fontWeightSemiBold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).dueDate,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorSchemes.gray,
                                    fontSize: 13,
                                    fontWeight: Constants.fontWeightSemiBold,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          formatDate(challenge.dueDate),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorSchemes.black,
                                    fontSize: 13,
                                    fontWeight: Constants.fontWeightSemiBold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).address,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorSchemes.gray,
                  fontSize: 13,
                  fontWeight: Constants.fontWeightSemiBold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            challenge.address,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorSchemes.black,
                  fontSize: 13,
                  fontWeight: Constants.fontWeightSemiBold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabeledValue(
    BuildContext context, {
    required String label,
    required Status value,
    bool isSpacer = false,
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
        SizedBox(height: isSpacer ? 16 : 4),
        StatusWidget(
          statusColor: value.color,
          statusMessage: value.name,
        ),
      ],
    );
  }
}
