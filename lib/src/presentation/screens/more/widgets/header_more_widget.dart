import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/domain/entities/home/user_info.dart';
import 'package:skeletons/skeletons.dart';

class HeaderMoreWidget extends StatelessWidget {
  final CurrentUserInfo user;
  final void Function() onTap;
  final void Function(String) onProfileTap;

  const HeaderMoreWidget({
    super.key,
    required this.onTap,
    required this.onProfileTap,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 76,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        decoration: const BoxDecoration(
          color: ColorSchemes.primary,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 8, bottom: 2),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: ColorSchemes.yellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 40),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: ColorSchemes.yellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _buildAvatar(),
                const SizedBox(width: 12),
                _buildUserInfo(context),
                const Spacer(),
                InkWell(
                  onTap: () => onProfileTap(""),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: !isRtl
                        ? Matrix4.rotationY(3.14159)
                        : Matrix4.rotationY(0),
                    child: SvgPicture.asset(
                      ImagePaths.arrowLeft,
                      width: 24,
                      height: 24,
                      color: ColorSchemes.white,
                      // matchTextDirection: true,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  margin: const EdgeInsets.only(top: 8),
                  decoration: const BoxDecoration(
                    color: ColorSchemes.yellow,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 4,
                  height: 4,
                  margin: const EdgeInsets.only(top: 2),
                  decoration: const BoxDecoration(
                    color: ColorSchemes.yellow,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image.network(
          "",
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => SvgPicture.asset(
            ImagePaths.avatar,
            fit: BoxFit.scaleDown,
          ),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return SkeletonLine(
              style: SkeletonLineStyle(
                width: double.infinity,
                height: double.infinity,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          user.userName,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorSchemes.white,
                fontSize: 16,
              ),
        ),
        Text(
          user.userEmail,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.white,
                fontSize: 14,
                fontWeight: Constants.fontWeightRegular,
              ),
        ),
      ],
    );
  }
}
