import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';

class ChallengeCardSkeleton extends StatelessWidget {
  const ChallengeCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorSchemes.border, width: 0.75),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLine(
                        style: SkeletonLineStyle(height: 14, width: 120)),
                    SizedBox(height: 8),
                    SkeletonLine(
                        style: SkeletonLineStyle(height: 12, width: 60)),
                  ],
                ),
              ),
              SkeletonAvatar(style: SkeletonAvatarStyle(width: 60, height: 24)),
            ],
          ),
          const SizedBox(height: 12),
          Container(height: 0.75, color: ColorSchemes.border),
          const SizedBox(height: 12),
          // User & Department
          const Row(
            children: [
              SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      shape: BoxShape.circle, width: 32, height: 32)),
              SizedBox(width: 8),
              SkeletonLine(style: SkeletonLineStyle(height: 14, width: 100)),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonLine(style: SkeletonLineStyle(height: 13, width: 50)),
                  SizedBox(height: 4),
                  SkeletonLine(style: SkeletonLineStyle(height: 14, width: 80)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Address
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonLine(style: SkeletonLineStyle(height: 13, width: 60)),
              SizedBox(height: 8),
              SkeletonLine(style: SkeletonLineStyle(height: 14, width: 200)),
            ],
          ),
          const SizedBox(height: 12),
          // Bottom labels (Severity and Workflow)
          const Row(
            children: [
              SkeletonLine(style: SkeletonLineStyle(height: 13, width: 100)),
              Spacer(),
              SkeletonLine(style: SkeletonLineStyle(height: 13, width: 100)),
            ],
          ),
        ],
      ),
    );
  }
}
