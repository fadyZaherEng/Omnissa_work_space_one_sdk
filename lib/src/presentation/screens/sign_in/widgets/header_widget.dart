import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/src/core/resources/image_paths.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          ImagePaths.logo,
          fit: BoxFit.scaleDown,
          height: 160,
          width: 154,
        ),
        const SizedBox(height: 36),
      ],
    );
  }
}
