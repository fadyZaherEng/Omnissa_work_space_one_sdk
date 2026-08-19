import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/utils/constants.dart';

class BuildUserAndDepartmentCardWidget extends StatelessWidget {
  final String name;
  final String label;
  final String value;
  final bool isRisk;
  final bool isChallenge;

  final bool isCategory;

  const BuildUserAndDepartmentCardWidget({
    super.key,
    required this.name,
    required this.label,
    required this.value,
    this.isRisk = false,
    this.isCategory = true,
    this.isChallenge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isChallenge
                      ? S.of(context).challengeOwner
                      : isRisk
                          ? S.of(context).projectName
                          : S.of(context).projectManager,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.gray,
                        fontSize: 13,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.black,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
              ],
            ),
          ),
          if (isCategory) const SizedBox(width: 16),
          if (isCategory)
            Expanded(
              child: _buildLabeledValue(
                context,
                label: label,
                value: value,
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
