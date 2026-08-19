import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/extensions/color_extension.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/domain/entities/home/milstones.dart';
import 'package:mofa/src/presentation/widgets/build_header_app_card.dart';

class MilstoneCardWidget extends StatelessWidget {
  final Milstones milstones;
  final void Function(Milstones) onTap;

  const MilstoneCardWidget({
    super.key,
    required this.milstones,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(milstones),
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
              title: milstones.name,
              statusColor: milstones.projectCardStatusStr.color.toColor(),
              status: milstones.projectCardStatusStr.label,
              id: "",
              showStatus: true,
            ),
            const SizedBox(height: 12),
            Container(height: 0.75, color: ColorSchemes.border),
            // const SizedBox(height: 12),
            // _buildUserAndDepartment(context),
            const SizedBox(height: 16),
            _buildProjectRow(context),
            const SizedBox(height: 16),
            _buildDatesRow(context),
            const SizedBox(height: 16),
            _buildDatesLineBasicsRow(context),
            const SizedBox(height: 16),
            _buildNumberOfDaysRow(context),
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
        children: [
          _buildAvatar(context, milstones.name),
          const SizedBox(width: 8),
          Text(
            milstones.name,
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
              value: formatDate(milstones.startDate.isEmpty
                  ? DateTime.now().toString()
                  : milstones.startDate),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).taskEndDate,
              value: formatDate(milstones.endDate.isEmpty
                  ? DateTime.now().toString()
                  : milstones.endDate),
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
              value: milstones.project.projectName,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).projectManager,
              value: milstones.project.projectManagerName,
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
              value: formatDate(milstones.baselineStartDate.isEmpty
                  ? DateTime.now().toString()
                  : milstones.endDate),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).endDateBasicsLine,
              value: formatDate(milstones.baselineEndDate.isEmpty
                  ? DateTime.now().toString()
                  : milstones.baselineEndDate),
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
              label: S.of(context).weight,
              value: "${milstones.weight} ${S.of(context).weight}",
            ),
          ),
          const SizedBox(width: 16),
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
