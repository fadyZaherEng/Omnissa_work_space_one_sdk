import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/domain/entities/shared/chart_graph.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CircleChartFullWidget extends StatelessWidget {
  final String? titleText;
  final List<ChartGraph> chartGraph;
  final VoidCallback onTap;

  const CircleChartFullWidget({
    super.key,
    this.titleText,
    required this.chartGraph,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            if (titleText != null)
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      titleText.toString(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorSchemes.primary,
                          ),
                    ),
                  ),
                  const Spacer(),
                  //view more button
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: ColorSchemes.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        S.of(context).viewMore,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorSchemes.white,
                              fontSize: 12,
                              fontWeight: Constants.fontWeightSemiBold,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: SizedBox(
                      height: 155,
                      child: ListView.builder(
                        itemCount: chartGraph.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: chartGraph[index].color,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  chartGraph[index].x,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontSize: 12,
                                        color: ColorSchemes.black,
                                      ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                chartGraph[index].y.toString(),
                                textAlign: TextAlign.end,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: 15,
                                      color: chartGraph[index].color,
                                    ),
                              ),
                              const SizedBox(width: 4),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.38,
                  height: 135,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.38,
                          height: 165,
                          child: SfCircularChart(
                            legend: const Legend(isVisible: false),
                            series: <CircularSeries>[
                              PieSeries<ChartGraph, String>(
                                dataSource: chartGraph,
                                xValueMapper: (ChartGraph data, _) => data.x,
                                yValueMapper: (ChartGraph data, _) => data.y,
                                pointColorMapper: (ChartGraph data, _) =>
                                    data.color,
                                dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  connectorLineSettings:
                                      const ConnectorLineSettings(
                                    type: ConnectorType.line,
                                    width: 0,
                                  ),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: ColorSchemes.white,
                                        fontSize: 14,
                                      ),
                                  labelPosition: ChartDataLabelPosition.inside,
                                ),
                                radius: '100%',
                                emptyPointSettings: EmptyPointSettings(
                                  mode: EmptyPointMode.zero,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
