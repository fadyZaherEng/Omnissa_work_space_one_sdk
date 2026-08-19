import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:skeletons/skeletons.dart';

class SettingsSkeleton extends StatelessWidget {
  const SettingsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchemes.moreBackground,
      appBar: buildAppBarWidget(
        context,
        title: S.of(context).settings,
        isHaveBackButton: true,
        onBackButtonPressed: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            _buildMenuSkeleton(),
            const SizedBox(height: 20),
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
