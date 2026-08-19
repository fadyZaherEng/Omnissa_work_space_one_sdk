import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/domain/entities/home/stratgy.dart';

class StrategyCardWidget extends StatelessWidget {
  final Strategy strategy;
  final void Function(Strategy) onTap;

  const StrategyCardWidget({
    super.key,
    required this.strategy,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(strategy),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Title text (no Expanded here)
                  Text(
                    strategy.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorSchemes.black,
                          fontSize:
                              strategy.name.split(" ").length > 3 ? 14 : 17,
                          fontWeight: Constants.fontWeightBold,
                        ),
                  ),
                  const SizedBox(height: 8),

                  /// ID or Strategy
                  Text(
                    strategy.strategyLevelName,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: ColorSchemes.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(height: 0.75, color: ColorSchemes.border),
            const SizedBox(height: 16),
            _buildDatesRow(context),
            const SizedBox(height: 16),
            _buildObjectiveRow(context),
            const SizedBox(height: 16),
          ],
        ),
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
              value: formatDate(
                strategy.startDate.isEmpty
                    ? DateTime.now().toString()
                    : strategy.startDate,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).endDate,
              value: formatDate(
                strategy.endDate.isEmpty
                    ? DateTime.now().toString()
                    : strategy.endDate,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObjectiveRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).objectivesCount,
              value: strategy.objectivesCount.toString(),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).initiativesCount,
              value: strategy.initiativesCount.toString(),
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
