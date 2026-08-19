import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/domain/entities/shared/chart_graph.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CircleChartHalfWidget extends StatelessWidget {
  final String? centerText;
  final String? titleText;
  final double externalPadding;
  final double topItemPadding;
  final List<ChartGraph> chartGraph;

  const CircleChartHalfWidget({
    super.key,
    this.centerText,
    this.titleText,
    this.externalPadding = 0,
    this.topItemPadding = 4,
    required this.chartGraph,
  });

  @override
  Widget build(BuildContext context) {
    final int fullHeight = 74 * chartGraph.length;
    final int halfHeight = 67 * chartGraph.length;

    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: externalPadding > 0 ? 1 : 8,
      ),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: chartGraph.length < 3 ? 220 : fullHeight.toDouble(),
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            if (titleText != null)
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: EdgeInsets.only(top: externalPadding),
                  child: Text(
                    "   $titleText" ?? " ",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorSchemes.primary,
                        ),
                  ),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: chartGraph.length < 3 ? 200 : halfHeight.toDouble(),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        Container(
                          width: 178 - (externalPadding * 2),
                          height: 178,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorSchemes.white,
                            border: Border.all(
                              color: ColorSchemes.secondary,
                              width: 45,
                            ),
                          ),
                          child: centerText != null
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Text(
                                      "$centerText\n ${S.of(context).project}",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: ColorSchemes.black,
                                            letterSpacing: -0.24,
                                          ),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: chartGraph.length < 3
                              ? 185
                              : halfHeight.toDouble(),
                          margin: EdgeInsetsDirectional.only(
                            end: externalPadding > 0 ? 6 : 4,
                          ),
                          child: SfCircularChart(
                            legend: Legend(
                              isVisible: true,
                              title: LegendTitle(
                                text: topItemPadding != 4 ? "" : " ",
                                alignment: ChartAlignment.far,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: 16,
                                      color: ColorSchemes.black,
                                    ),
                              ),
                              position: LegendPosition.left,
                              shouldAlwaysShowScrollbar: true,
                              toggleSeriesVisibility: true,
                              legendItemBuilder: (
                                txt,
                                series,
                                pointIndex,
                                seriesIndex,
                              ) {
                                final ChartGraph dataPoint =
                                    chartGraph[seriesIndex];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: topItemPadding,
                                        ),
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: dataPoint.color,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            (externalPadding > 0 ? 0.32 : 0.35),
                                        child: Row(
                                          children: [
                                            Text(
                                              dataPoint.x,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: ColorSchemes.black,
                                                    fontSize: 13,
                                                  ),
                                            ),
                                            const SizedBox(width: 20),
                                            Text(
                                              '${dataPoint.y}',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: dataPoint.color,
                                                    fontSize: 13,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            series: <CircularSeries>[
                              DoughnutSeries<ChartGraph, String>(
                                dataSource: chartGraph,
                                xValueMapper: (ChartGraph data, _) => data.x,
                                yValueMapper: (ChartGraph data, _) => data.y,
                                pointColorMapper: (ChartGraph data, _) =>
                                    data.color,
                                dataLabelSettings: DataLabelSettings(
                                  isVisible: false,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: ColorSchemes.white),
                                  labelPosition: ChartDataLabelPosition.inside,
                                  showZeroValue: false,
                                ),
                                radius: '100%',
                                innerRadius: '75%',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
