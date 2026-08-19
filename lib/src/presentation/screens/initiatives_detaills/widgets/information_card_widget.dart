import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/domain/entities/home/information.dart';
import 'package:mofa/src/domain/entities/shared/chart_graph.dart';
import 'package:mofa/src/presentation/widgets/circle_chart_half_widget.dart';
import 'package:mofa/src/presentation/widgets/progress_horizantal_indicator_widget.dart';
import 'package:mofa/src/presentation/widgets/status_widget.dart';

class InformationCardWidget extends StatefulWidget {
  final Information information;
  final void Function(Information) onTap;
  final List<ChartGraph> chartGraph;

  const InformationCardWidget({
    super.key,
    required this.information,
    required this.onTap,
    required this.chartGraph,
  });

  @override
  State<InformationCardWidget> createState() => _InformationCardWidgetState();
}

class _InformationCardWidgetState extends State<InformationCardWidget> {
  bool isOutputExpanded = false;
  bool isLandMarkExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(widget.information),
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
            const SizedBox(height: 16),
            _buildDatesRow(context),
            const SizedBox(height: 16),
            _buildProgressSection(context),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(height: 0.75, color: ColorSchemes.border),
            ),
            const SizedBox(height: 16),
            _buildOutputSection(context),
            const SizedBox(height: 16),
            _buildLandMarkSection(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOutputSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${S.of(context).output}(2)",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.primary,
                      fontWeight: Constants.fontWeightSemiBold,
                      fontSize: 15,
                    ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  setState(() {
                    isOutputExpanded = !isOutputExpanded;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorSchemes.secondary,
                  ),
                  child: SvgPicture.asset(
                    isOutputExpanded
                        ? ImagePaths.arrowUp
                        : ImagePaths.arrowDown,
                    width: 16,
                    height: 16,
                    fit: BoxFit.scaleDown,
                    color: ColorSchemes.black,
                  ),
                ),
              ),
            ],
          ),
          if (isOutputExpanded) const SizedBox(height: 4),
          if (isOutputExpanded)
            SizedBox(
              height: 190,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                shrinkWrap: true,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return Container(
                    height: 190,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: const BoxDecoration(
                      color: ColorSchemes.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: CircleChartHalfWidget(
                      externalPadding: 16,
                      chartGraph: widget.chartGraph,
                      topItemPadding: widget.chartGraph.length > 5 ? 4 : 6.5,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLandMarkSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).landmarks,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.primary,
                      fontWeight: Constants.fontWeightSemiBold,
                      fontSize: 15,
                    ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  setState(() {
                    isLandMarkExpanded = !isLandMarkExpanded;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorSchemes.secondary,
                  ),
                  child: SvgPicture.asset(
                    isLandMarkExpanded
                        ? ImagePaths.arrowUp
                        : ImagePaths.arrowDown,
                    width: 16,
                    height: 16,
                    fit: BoxFit.scaleDown,
                    color: ColorSchemes.black,
                  ),
                ),
              ),
            ],
          ),
          if (isLandMarkExpanded) const SizedBox(height: 4),
          if (isLandMarkExpanded)
            Text(
              widget.information.managerName,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: ColorSchemes.black,
                  ),
            ),
        ],
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
          StatusWidget(
            statusColor: widget.information.statusColor,
            statusMessage: widget.information.status,
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
              value: widget.information.startDate,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLabeledValue(
              context,
              label: S.of(context).endDate,
              value: widget.information.endDate,
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
                  status: widget.information.planProgress,
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
                  status: widget.information.achievedProgress,
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
