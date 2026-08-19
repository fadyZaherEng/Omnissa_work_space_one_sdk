import 'package:flutter/material.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:skeletons/skeletons.dart';

class AgreementsCardSkeletonWidget extends StatelessWidget {
  const AgreementsCardSkeletonWidget({super.key});

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
          // Header
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: 120,
                      height: 14,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      width: 40,
                      height: 12,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: 64,
                  height: 20,
                  borderRadius: BorderRadius.circular(4),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: ColorSchemes.border, thickness: 0.75),
          const SizedBox(height: 12),

          // User and Date
          Row(
            children: [
              const SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: 32,
                  height: 32,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              SkeletonLine(
                style: SkeletonLineStyle(
                  width: 100,
                  height: 14,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      width: 80,
                      height: 10,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      width: 100,
                      height: 14,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: ColorSchemes.border, thickness: 0.75),
          const SizedBox(height: 12),

          // Buttons
          Row(
            children: [
              Expanded(
                child: SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 40,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 40,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
