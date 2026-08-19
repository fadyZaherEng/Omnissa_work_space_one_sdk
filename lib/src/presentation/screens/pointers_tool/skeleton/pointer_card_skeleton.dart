import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';

class PointerCardSkeleton extends StatelessWidget {
  const PointerCardSkeleton({super.key});

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
        children: [
          Row(
            children: [
              Column(
                children: [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 16,
                      width: 180,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 16,
                      width: 180,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: 60,
                  height: 20,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Colors.grey),
          const SizedBox(height: 16),
          Row(
            children: [
              const SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  shape: BoxShape.circle,
                  width: 32,
                  height: 32,
                ),
              ),
              const SizedBox(width: 8),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 14,
                  width: 80,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Column(
                children: [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 14,
                      width: 100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 14,
                      width: 100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 14,
                      width: 100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 14,
                      width: 100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
