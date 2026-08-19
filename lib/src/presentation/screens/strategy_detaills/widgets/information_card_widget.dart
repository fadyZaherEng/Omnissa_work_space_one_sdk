import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/domain/entities/home/information.dart';
import 'package:mofa/src/presentation/widgets/build_user_and_department_icon_card_widget.dart';
import 'package:mofa/src/presentation/widgets/progress_horizantal_indicator_widget.dart';
import 'package:mofa/src/presentation/widgets/status_widget.dart';

class InformationCardWidget extends StatelessWidget {
  final Information information;
  final void Function(Information) onTap;

  const InformationCardWidget({
    super.key,
    required this.information,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(information),
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
            _buildHeader(context),
            const SizedBox(height: 12),
            Container(height: 0.75, color: ColorSchemes.border),
            const SizedBox(height: 12),
            BuildUserAndDepartmentCardIconWidget(
              name: information.managerName,
              path: ImagePaths.ownerManager,
            ),
            const SizedBox(height: 16),
            _buildDatesRow(context),
            const SizedBox(height: 16),
            _buildProgressSection(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text(
          //   GetLanguageUseCase(injector())() == "ar"
          //       ? "#${information.id}"
          //       : "${information.id}#",
          //   style: Theme.of(context)
          //       .textTheme
          //       .bodySmall
          //       ?.copyWith(color: ColorSchemes.primary),
          // ),
          // const SizedBox(width: 8),
          StatusWidget(
            statusColor: information.statusColor,
            statusMessage: information.status,
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
              label: S.of(context).startDate,
              value: information.startDate,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).endDate,
              value: information.endDate,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  S.of(context).planned,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.gray,
                        fontSize: 13,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
                const SizedBox(height: 8),
                ProgressHorizontalIndicatorWidget(
                  status: information.planProgress,
                ),
              ],
            ),
          ),
          const SizedBox(width: 64),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  S.of(context).progressPercentage,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.gray,
                        fontSize: 13,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
                const SizedBox(height: 8),
                ProgressHorizontalIndicatorWidget(
                  status: information.achievedProgress,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabeledValue(
    BuildContext context, {
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
                fontSize: 13,
                fontWeight: Constants.fontWeightSemiBold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.black,
                fontWeight: Constants.fontWeightSemiBold,
              ),
        ),
      ],
    );
  }
}
