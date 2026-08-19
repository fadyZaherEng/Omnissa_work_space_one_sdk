import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:skeletons/skeletons.dart';

class MoreSkeleton extends StatelessWidget {
  const MoreSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchemes.moreBackground,
      appBar: buildAppBarWidget(
        context,
        title: S.of(context).more,
        isHaveBackButton: false,
        actionWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SvgPicture.asset(
            ImagePaths.settings,
            width: 24,
            height: 24,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildUserCardSkeleton(),
            const SizedBox(height: 20),
            _buildMenuSkeleton(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCardSkeleton() {
    return SkeletonItem(
      child: Container(
        height: 76,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorSchemes.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SkeletonAvatar(
              style: SkeletonAvatarStyle(
                shape: BoxShape.circle,
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 12,
                    width: 80,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 6),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 10,
                    width: 50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            const Spacer(),
            const SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 24,
                height: 24,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSkeleton() {
    return Container(
      decoration: BoxDecoration(
        color: ColorSchemes.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: List.generate(10, (index) {
          return SkeletonItem(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  const SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: 24,
                      height: 24,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 12,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: 24,
                      height: 24,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
