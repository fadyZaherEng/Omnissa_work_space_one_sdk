import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';

class BuildOptionWidget extends StatelessWidget {
  final String title;
  final String image;
  final void Function() onTap;

  const BuildOptionWidget({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _buildOptionWidget(
      context: context,
      title: title,
      image: image,
      onTap: onTap,
    );
  }

  Widget _buildOptionWidget({
    required BuildContext context,
    required String title,
    required String image,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 85,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorSchemes.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorSchemes.border, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
              color: ColorSchemes.black,
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: ColorSchemes.black),
            ),
          ],
        ),
      ),
    );
  }
}
