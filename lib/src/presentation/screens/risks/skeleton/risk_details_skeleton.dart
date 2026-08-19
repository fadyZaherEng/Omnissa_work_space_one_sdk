import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class RiskDetailsSkeleton extends StatelessWidget {
  const RiskDetailsSkeleton({super.key});

  Widget _buildFieldSkeleton() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 16,
            width: 100,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
        SizedBox(height: 8),
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 20,
            width: double.infinity,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Skeleton
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 28,
              width: 200,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 24),

          // Fields Skeleton
          ...List.generate(
              16,
              (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildFieldSkeleton(),
                  )),
        ],
      ),
    );
  }
}
