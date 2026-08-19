import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/domain/entities/shared/chart_graph.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CircleChartHalfWithoutLegendWidget extends StatelessWidget {
  final String? centerText;
  final String? titleText;
  final List<ChartGraph> chartGraph;

  const CircleChartHalfWithoutLegendWidget({
    super.key,
    this.centerText,
    this.titleText,
    required this.chartGraph,
  });

  @override
  Widget build(BuildContext context) {
    ChartGraph lastItem = chartGraph[chartGraph.length - 1];
    //remove last item
    chartGraph.remove(lastItem);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                if (titleText != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "$titleText (${lastItem.y.toString()})" ?? " ",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorSchemes.primary,
                          ),
                    ),
                  ),

                const Spacer(),
                //view more button
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
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
                const SizedBox(width: 8),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.38,
                  height: 135,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.38,
                        height: 135,
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
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.38,
                        height: 165,
                        child: SfCircularChart(
                          legend: const Legend(isVisible: false),
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
                              radius: '92.5%',
                              innerRadius: '71.5%',
                            ),
                          ],
                        ),
                      ),
                    ],
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
