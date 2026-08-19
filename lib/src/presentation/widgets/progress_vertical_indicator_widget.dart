import 'package:flutter/material.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';

class ProgressVerticalIndicatorWidget extends StatelessWidget {
  final double percentage;
  final String progressName;
  final Color? color;

  const ProgressVerticalIndicatorWidget({
    super.key,
    required this.percentage,
    required this.progressName,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final clampedPercentage = (percentage / 100).clamp(0.0, 1.0);
    final activeWidth = 200 * clampedPercentage;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Background Bar
                Container(
                  height: 200,
                  width: 12,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(230, 233, 240, 0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                // Active Progress Bar
                Container(
                  height: activeWidth,
                  width: 12,
                  decoration: BoxDecoration(
                    color: color ?? ColorSchemes.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            progressName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorSchemes.gray,
                  fontSize: 11,
                  letterSpacing: -0.13,
                ),
          ),
        ],
      ),
    );
  }
}
