import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/extensions/color_extension.dart';
import 'package:mofa/src/domain/entities/home/home_static.dart';

class KPIWidgets extends StatelessWidget {
  final HomeStatistics homeStatistics;
  final bool isKPI;
  final VoidCallback onTap;

  const KPIWidgets({
    super.key,
    required this.homeStatistics,
    this.isKPI = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              homeStatistics.title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorSchemes.primary,
                  ),
            ),
            const Spacer(),
            //view more button
            InkWell(
              onTap: onTap,
              child: Container(
                margin: const EdgeInsets.only(top: 8),
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
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            if (homeStatistics.items.isNotEmpty)
              _buildKPIWidget(
                context: context,
                title: homeStatistics.items.first.label,
                subtitle: homeStatistics.items.first.count,
                path: !isKPI ? ImagePaths.hourglass : ImagePaths.refresh,
                color: homeStatistics.items.first.color.toColor(),
              ),
            const SizedBox(width: 24),
            if (homeStatistics.items.isNotEmpty &&
                homeStatistics.items.length > 1)
              _buildKPIWidget(
                context: context,
                title: homeStatistics.items[1].label,
                subtitle: homeStatistics.items[1].count,
                path: !isKPI ? ImagePaths.documents : ImagePaths.statistics,
                color: homeStatistics.items[1].color.toColor(),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildKPIWidget({
    required BuildContext context,
    required String title,
    required int subtitle,
    required String path,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        width: 143,
        height: 143,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              path,
              width: 32,
              height: 32,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorSchemes.white,
                    fontSize: 20,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorSchemes.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
