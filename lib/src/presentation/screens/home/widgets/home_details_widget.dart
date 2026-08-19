import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';

class HomeDetailsWidget extends StatelessWidget {
  final void Function() onTapStrategy;
  final void Function() onTapAgreements;
  final void Function() onTapProject;
  final void Function() onTapRisks;
  final void Function() onTapChallenges;
  final bool isVisibleAgreements;
  final bool isVisibleStrategy;
  final bool isVisibleProject;
  final bool isVisibleRisks;
  final bool isVisibleChallenges;

  const HomeDetailsWidget({
    super.key,
    required this.onTapStrategy,
    required this.onTapProject,
    required this.onTapRisks,
    required this.onTapChallenges,
    required this.onTapAgreements,
    required this.isVisibleAgreements,
    required this.isVisibleStrategy,
    required this.isVisibleProject,
    required this.isVisibleRisks,
    required this.isVisibleChallenges,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(isVisibleProject)
            Expanded(
              child: _buildItemWidget(
                title: S.of(context).projects,
                path: ImagePaths.homeProjects,
                color: const Color(0xFF0d614f),
                context: context,
                onTap: onTapProject,
              ),
            ),
            if(isVisibleStrategy )
            const SizedBox(width: 16),
            // Expanded(
            //   child: _buildItemWidget(
            //       title: S.of(context).agreements,
            //       path: ImagePaths.checkMark,
            //       color: const Color(0xFFffbf00),
            //       context: context,
            //       onTap: onTapAgreements),
            // ),
            if(isVisibleStrategy)
            Expanded(
              child: _buildItemWidget(
                title: S.of(context).deliverables,
                path: ImagePaths.task,
                color: const Color(0xFFffbf00),
                context: context,
                onTap: onTapStrategy,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(isVisibleRisks)
            Expanded(
              child: _buildItemWidget(
                title: S.of(context).risks,
                path: ImagePaths.risks,
                color: const Color(0xFFeddbcc),
                context: context,
                onTap: onTapRisks,
              ),
            ),
            if(isVisibleChallenges)
            const SizedBox(width: 16),
            if(isVisibleChallenges)
            Expanded(
              child: _buildItemWidget(
                title: S.of(context).challenges,
                path: ImagePaths.challenges,
                color: const Color(0xFFa6a8ab),
                context: context,
                onTap: onTapChallenges,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildItemWidget({
    required String title,
    required String path,
    required Color color,
    required BuildContext context,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 104,
        decoration: BoxDecoration(
          color: ColorSchemes.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    path,
                    width: 32,
                    height: 32,
                    fit: BoxFit.scaleDown,
                    color: ColorSchemes.white,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.white,
                      fontSize: 14,
                      fontWeight: Constants.fontWeightSemiBold,
                    ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
