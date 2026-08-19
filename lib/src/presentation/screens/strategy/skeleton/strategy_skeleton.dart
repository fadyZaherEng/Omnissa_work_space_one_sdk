import 'package:flutter/material.dart';
import 'package:mofa/src/presentation/screens/strategy/skeleton/strategy_card_skeleton.dart';
import 'package:skeletons/skeletons.dart';

class StrategySkeleton extends StatelessWidget {
  const StrategySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 38,
                width: MediaQuery.of(context).size.width,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 38,
                    width: 85,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => const StrategyCardSkeleton(),
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: 10,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
