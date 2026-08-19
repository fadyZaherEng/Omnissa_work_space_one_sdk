import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/extensions/color_extension.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/domain/entities/home/deliverables.dart';
import 'package:mofa/src/presentation/widgets/build_header_app_card.dart';

class DelivrableCardWidget extends StatelessWidget {
  final Deliverbles deliverables;
  final void Function(Deliverbles) onTap;

  const DelivrableCardWidget({
    super.key,
    required this.deliverables,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(deliverables),
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
              title: deliverables.deliverableName,
              statusColor: deliverables.deliverableStatusColor.color.toColor(),
              status: deliverables.deliverableStatusColor.label,
              id: "",
            ),
            const SizedBox(height: 12),
            Container(height: 0.75, color: ColorSchemes.border),
            const SizedBox(height: 12),
            _buildUserAndDepartment(context),
            const SizedBox(height: 16),
            _buildDatesRow(context),
            const SizedBox(height: 16),

            _buildProjectRow(context),

            // const SizedBox(height: 16),
            // _buildDatesLineBasicsRow(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildUserAndDepartment(BuildContext context) {
    return Padding(
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
                // _buildAvatar(context, deliverables.deliverableName),
                // const SizedBox(width: 8),

                Text(
                  S.of(context).projectName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.gray,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  deliverables.projectName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.black,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  S.of(context).projectManager,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.gray,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  deliverables.projectManagerStr,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.black,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
              ],
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
              label: S.of(context).deliveryStartDate,
              value: formatDate(
                deliverables.projectStartDate.isEmpty
                    ? DateTime.now().toString()
                    : deliverables.projectStartDate,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).deliveryEndDate,
              value: formatDate(
                deliverables.projectEndDate.isEmpty
                    ? DateTime.now().toString()
                    : deliverables.projectEndDate,
              ),
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
          // Expanded(
          //   child: _buildLabeledValue(
          //     context,
          //     label: S.of(context).projectName,
          //     value: deliverables.projectName,
          //   ),
          // ),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).weight,
              value: "${deliverables.weight} ${S.of(context).weight}",
            ),
          ),
          // const SizedBox(width: 16),
          // Expanded(
          //   child: _buildLabeledValue(
          //     context,
          //     label: S.of(context).projectStatus,
          //     value: deliverables.deliverableStatusColor.label,
          //     color: ColorSchemes.yellow,
          //   ),
          // ),
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
              value: formatDate(deliverables.baselineStartDate.isEmpty
                  ? DateTime.now().toString()
                  : deliverables.baselineStartDate),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).endDateBasicsLine,
              value: formatDate(deliverables.baselineEndDate.isEmpty
                  ? DateTime.now().toString()
                  : deliverables.baselineEndDate),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberOfDaysRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildLabeledValue(
            context,
            label: S.of(context).weight,
            value: "${deliverables.weight} ${S.of(context).weight}",
          ),
        ),
        const SizedBox(width: 16),
      ],
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
