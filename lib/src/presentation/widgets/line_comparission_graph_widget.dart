import 'package:flutter/material.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/domain/entities/shared/chart_graph.dart';
import 'package:mofa/src/presentation/widgets/progress_vertical_indicator_widget.dart';

class LineGraphCompressionGraphWidget extends StatelessWidget {
  const LineGraphCompressionGraphWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> kilos = ["20k", "40k", "60k", "80k", "100k"];
    List<ChartGraph> chartGraph = [
      const ChartGraph(x: 'David', y: 60, color: ColorSchemes.primary),
      const ChartGraph(x: 'Steve', y: 55, color: ColorSchemes.primary),
      const ChartGraph(x: 'Jack', y: 70, color: ColorSchemes.primary),
      const ChartGraph(x: 'John', y: 60, color: ColorSchemes.primary),
      const ChartGraph(x: 'Others', y: 70, color: ColorSchemes.primary),
      const ChartGraph(x: 'Alex', y: 85, color: ColorSchemes.primary),
    ];
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: kilos.reversed
                  .map(
                    (e) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          e,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 11,
                                    color: ColorSchemes.gray,
                                  ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          for (ChartGraph graph in chartGraph)
            Expanded(
              child: ProgressVerticalIndicatorWidget(
                percentage: graph.y.toDouble(),
                progressName: graph.x,
              ),
            ),
        ],
      ),
    );
  }
}
