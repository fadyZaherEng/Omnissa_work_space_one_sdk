import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/extensions/color_extension.dart';
import 'package:mofa/src/core/utils/format_date.dart';
import 'package:mofa/src/domain/entities/home/out_put.dart';
import 'package:mofa/src/domain/entities/shared/status.dart';
import 'package:mofa/src/presentation/widgets/progress_horizantal_indicator_widget.dart';
import 'package:mofa/src/presentation/widgets/status_widget.dart';

class OutPutCardWidget extends StatelessWidget {
  final OutPut output;
  final void Function(OutPut) onTap;

  const OutPutCardWidget({
    super.key,
    required this.output,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(output),
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

            /// ✅ Milestone indicator
            if (output.hasMileStone) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: ColorSchemes.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: ColorSchemes.primary,
                      width: 0.75,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.flag,
                        size: 16,
                        color: ColorSchemes.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        S.of(context).milestone,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: ColorSchemes.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 12),
            Container(height: 0.75, color: ColorSchemes.border),
            const SizedBox(height: 12),
            _buildDatesRow(context),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildLabeledValue(
                context,
                label: S.of(context).weight,
                value: output.weight.toString().isNotEmpty
                    ? output.weight.toString()
                    : "---",
              ),
            ),
            const SizedBox(height: 8),
            _buildProgressSection(context),
            const SizedBox(height: 16),
            if (output.attachments.isNotEmpty)
              Container(height: 0.75, color: ColorSchemes.border),
            if (output.attachments.isNotEmpty) const SizedBox(height: 12),
            if (output.attachments.isNotEmpty) _buildAttachmentsWidget(context),
            if (output.attachments.isNotEmpty) const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              output.deliverableName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorSchemes.black,
                    fontSize: 14,
                    fontWeight: Constants.fontWeightSemiBold,
                  ),
            ),
          ),
          const SizedBox(width: 8),
          StatusWidget(
            statusColor: output.deliverableStatusColor.color.toColor(),
            statusMessage: output.deliverableStatusColor.label,
          ),
        ],
      ),
    );
  }

  Widget _buildDatesRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildLabeledValue(
                  context,
                  label: S.of(context).startDate,
                  value: formatDate(
                    output.deliverableStartDate.isNotEmpty
                        ? output.deliverableStartDate
                        : DateTime.now().toString(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildLabeledValue(
                  context,
                  label: S.of(context).endDate,
                  value: formatDate(
                    output.deliverableEndDate.isNotEmpty
                        ? output.deliverableEndDate
                        : DateTime.now().toString(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildLabeledValue(
            context,
            label: S.of(context).startDateBasicsLine,
            value: formatDate(
              output.baselineStartDate.isNotEmpty
                  ? output.baselineStartDate
                  : DateTime.now().toString(),
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
          if (output.planProgress.percentage != 0)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).achievements,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorSchemes.gray,
                          fontSize: 13,
                          fontWeight: Constants.fontWeightSemiBold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  ProgressHorizontalIndicatorWidget(
                    status: output.planProgress,
                  ),
                ],
              ),
            ),
          if (output.planProgress.percentage != 0) const SizedBox(width: 64),
          // if (output.completionPercentage != 0)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  S.of(context).achievements,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.gray,
                        fontSize: 13,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
                const SizedBox(height: 8),
                ProgressHorizontalIndicatorWidget(
                  status: Status(
                    percentage: output.completionPercentage.toDouble(),
                    color: Colors.green,
                  ),
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

  Widget _buildAttachmentsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            S.of(context).attachments,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorSchemes.primary,
                  fontWeight: Constants.fontWeightSemiBold,
                  fontSize: 15,
                ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: output.attachments.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) => Row(
                  children: [
                    SvgPicture.asset(
                      output.attachments[index].isPdf
                          ? ImagePaths.pdf
                          : ImagePaths.xls,
                      width: 20,
                      height: 20,
                      fit: BoxFit.scaleDown,
                      color: ColorSchemes.primary,
                    ),
                    const SizedBox(width: 9),
                    Text(
                      output.attachments[index].name,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: ColorSchemes.black,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
