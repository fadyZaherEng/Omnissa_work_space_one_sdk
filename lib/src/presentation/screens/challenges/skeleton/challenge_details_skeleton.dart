import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ChallengeDetailsSkeleton extends StatelessWidget {
  const ChallengeDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Skeleton
          const SkeletonLine(
            style: SkeletonLineStyle(
              height: 32,
              width: 250,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
          const SizedBox(height: 16),

          // Status Chips Row
          const Row(
            children: [
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 32,
                  width: 80,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              SizedBox(width: 8),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 32,
                  width: 80,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Main Content
          ...List.generate(
            10,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 16,
                      width: 120,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 20,
                      width: double.infinity,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
