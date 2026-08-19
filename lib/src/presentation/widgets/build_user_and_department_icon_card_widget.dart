import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';

class BuildUserAndDepartmentCardIconWidget extends StatelessWidget {
  final String name;
  final String? path;

  const BuildUserAndDepartmentCardIconWidget({
    super.key,
    required this.name,
    this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                _buildAvatar(context),
                const SizedBox(width: 8),
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.black,
                        fontWeight: Constants.fontWeightSemiBold,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ColorSchemes.primary,
      ),
      child: Center(
        child: SvgPicture.asset(
          path ?? ImagePaths.building,
          width: 16,
          height: 16,
          fit: BoxFit.scaleDown,
          color: ColorSchemes.white,
        ),
      ),
    );
  }
}
