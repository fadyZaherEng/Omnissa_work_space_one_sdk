import 'package:flutter/material.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:skeletons/skeletons.dart';

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildHomeHeaderSkeleton(context),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 38,
                          width: 100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 212,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          shrinkWrap: true,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            return Container(
                                height: 218,
                                width: MediaQuery.of(context).size.width * 0.85,
                                decoration: const BoxDecoration(
                                  color: ColorSchemes.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                child: SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 218,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                ));
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 38,
                          width: 100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildHomeDetailsSkeleton(context),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              // Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeHeaderSkeleton(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            const SkeletonAvatar(
              style: SkeletonAvatarStyle(
                shape: BoxShape.circle,
                width: 48,
                height: 48,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    height: 12,
                    width: 80,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        const SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: 40,
            height: 40,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  Widget _buildHomeDetailsSkeleton(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildSkeletonItem(context)),
            const SizedBox(width: 16),
            Expanded(child: _buildSkeletonItem(context)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildSkeletonItem(context)),
            const SizedBox(width: 16),
            Expanded(child: _buildSkeletonItem(context)),
          ],
        ),
      ],
    );
  }

  Widget _buildSkeletonItem(context) {
    return SkeletonLine(
      style: SkeletonLineStyle(
        height: 104,
        width: MediaQuery.of(context).size.width,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
