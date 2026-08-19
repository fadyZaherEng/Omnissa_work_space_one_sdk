import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/domain/entities/home/complinace.dart';
import 'package:mofa/src/presentation/widgets/status_widget.dart';

class ComplinaceCardWidget extends StatelessWidget {
  final Complinace compliance;
  final void Function(Complinace) onTap;

  const ComplinaceCardWidget({
    super.key,
    required this.compliance,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(compliance),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        // margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorSchemes.border, width: 0.75),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 12),
            Container(height: 0.75, color: ColorSchemes.border),
            const SizedBox(height: 12),
            _buildInfoSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              compliance.taskName.isNotEmpty ? compliance.taskName : "---",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorSchemes.black,
                    fontSize: 14,
                    fontWeight: Constants.fontWeightSemiBold,
                  ),
            ),
          ),
          const SizedBox(width: 8),
          StatusWidget(
            statusColor: ColorSchemes.primary,
            statusMessage: compliance.complianceRateStr.isNotEmpty
                ? compliance.complianceRateStr
                : '${compliance.complianceRate}%',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabeledValue(
            context,
            label: S.of(context).activityName,
            value: compliance.activityName,
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildLabeledValue(
                  context,
                  label: S.of(context).processName,
                  value: compliance.processName,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildLabeledValue(
                  context,
                  label: S.of(context).phaseName,
                  value: compliance.phaseName,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildLabeledValue(
                  context,
                  label: S.of(context).stageName,
                  value: compliance.stageName,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildLabeledValue(
                  context,
                  label: S.of(context).mark,
                  value: compliance.mark.toString(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildLabeledValue(
                  context,
                  label: S.of(context).complianceRate,
                  value: '${compliance.complianceRate}%',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildLabeledValue(
                  context,
                  label: S.of(context).discoveryDate,
                  value: compliance.discoveryDate.isNotEmpty
                      ? formatDate(compliance.discoveryDate)
                      : '---',
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildLabeledValue(
                  context,
                  label: S.of(context).resolutionDate,
                  value: compliance.resolutionDate.isNotEmpty
                      ? formatDate(compliance.resolutionDate)
                      : '---',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildLabeledValue(
                  context,
                  label: S.of(context).recommendations,
                  value: compliance.recommendations.isNotEmpty
                      ? compliance.recommendations
                      : "---",
                ),
              ),
            ],
          ),
          _buildLabeledValue(
            context,
            label: S.of(context).observation,
            value: compliance.observation.isNotEmpty
                ? compliance.observation
                : "---",
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
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
            value.isNotEmpty ? value.trim() : '---',
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
}
