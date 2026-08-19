import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/extensions/color_extension.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/domain/entities/home/risks.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';
import 'package:mofa/src/presentation/widgets/build_header_app_card.dart';
import 'package:mofa/src/presentation/widgets/build_user_and_department_card_widget.dart';
import 'package:mofa/src/presentation/widgets/status_widget.dart';

class RisksCardWidget extends StatelessWidget {
  final Risks risk;
  final void Function(Risks) onTap;

  const RisksCardWidget({
    super.key,
    required this.risk,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(risk),
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
              title: risk.title,
              statusColor: risk.statusColor.color.toColor(),
              status: risk.statusColor.label,
              id: "",
              isSevity: true,
              sevityStatusColor: risk.severityColor,
              showStatus: false,
            ),
            const SizedBox(height: 12),
            Container(height: 0.75, color: ColorSchemes.border),
            const SizedBox(height: 12),
            BuildUserAndDepartmentCardWidget(
              name: risk.projectName,
              label: S.of(context).projectManager,
              value: risk.projectManagerStr,
              isRisk: true,
            ),
            const SizedBox(height: 8),
            // BuildUserAndDepartmentCardWidget(
            //   name: risk.projectManagerStr,
            //   label: S.of(context).assignTo,
            //   value: risk.assignedTo,
            // ),
            // const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildDate(
                      context,
                      label: S.of(context).assignTo,
                      value: risk.assignedTo,
                      isDate: false,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDate(
                      context,
                      label: S.of(context).dueDate,
                      value: risk.dueDate,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            if (risk.address.isNotEmpty) _buildAddressRow(context),
            if (risk.address.isNotEmpty) const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (risk.riskStrong.name.isNotEmpty)
                    _buildLabeledValue(
                      context,
                      label: S.of(context).riskStrong,
                      value: risk.riskStrong,
                    ),
                  const SizedBox(width: 16),
                  const Spacer(),
                  if (risk.workflowCases.name.isNotEmpty)
                    Expanded(
                      flex: 2,
                      child: _buildLabeledValue(
                        context,
                        label: S.of(context).workflowCases,
                        value: risk.workflowCases,
                        isSpacer: true,
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
            risk.address,
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

  Widget _buildDate(
    BuildContext context, {
    required String label,
    required String value,
    bool isSpacer = false,
    bool isDate = true,
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
        Text(
          !isDate ? value : formatDate(value),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.black,
                fontSize: 13,
                fontWeight: Constants.fontWeightSemiBold,
              ),
        ),
      ],
    );
  }
}
