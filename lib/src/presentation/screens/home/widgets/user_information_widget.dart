import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/domain/entities/home/user_info.dart';
import 'package:skeletons/skeletons.dart';

class UserInformationWidget extends StatelessWidget {
  final CurrentUserInfo user;
  final Function(String) onTapImageProfile;

  const UserInformationWidget({
    super.key,
    required this.user,
    required this.onTapImageProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => onTapImageProfile(user.userEmailAccessRequest),
          child: Container(
            clipBehavior: Clip.antiAlias,
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                user.userEmailAccessRequest,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: SvgPicture.asset(
                      ImagePaths.logo,
                      fit: BoxFit.fill,
                    ),
                  );
                },
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: SkeletonLine(
                      style: SkeletonLineStyle(
                        width: double.infinity,
                        height: double.infinity,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).greeting,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorSchemes.gray,
                    letterSpacing: -0.24,
                  ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                user.userName,
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.black,
                      letterSpacing: -0.24,
                      fontWeight: Constants.fontWeightSemiBold,
                      fontSize: 16,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
