import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';

AppBar buildSortFilterAppBarWidget(
  BuildContext context, {
  required String title,
  required bool isHaveBackButton,
  Function()? onBackButtonPressed,
  Color backgroundColor = ColorSchemes.white,
  Color textColor = ColorSchemes.black,
  Widget actionWidget = const SizedBox.shrink(),
  String imagePath = "",
  bool? centredTitle = false,
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    title: imagePath.isEmpty
        ? Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  letterSpacing: -0.24,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        : SvgPicture.asset(
            imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.contain,
          ),
    centerTitle: centredTitle ?? true,
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: ColorSchemes.secondary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: SvgPicture.asset(
                    ImagePaths.icSort,
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                    color: ColorSchemes.iconBackground,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: ColorSchemes.secondary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: SvgPicture.asset(
                    ImagePaths.icFilter,
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                    color: ColorSchemes.iconBackground,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ],
    leading: isHaveBackButton
        ? InkWell(
            onTap: onBackButtonPressed ?? () {},
            child: SvgPicture.asset(
              ImagePaths.backArrow,
              matchTextDirection: true,
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
              color: ColorSchemes.black,
            ),
          )
        : const SizedBox.shrink(),
  );
}
