import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart' as badge;
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/entities/home/user_info.dart';
import 'package:mofa/src/domain/usecase/get_language_use_case.dart';
import 'package:mofa/src/presentation/screens/home/widgets/user_information_widget.dart';

class HomeHeaderSection extends StatelessWidget {
  final int notificationCount;
  final Function() onNotificationTapped;
  final Function() onLanguageTapped;
  final Function(String) onTapImageProfile;
  final CurrentUserInfo user;

  const HomeHeaderSection({
    super.key,
    required this.user,
    required this.notificationCount,
    required this.onNotificationTapped,
    required this.onTapImageProfile,
    required this.onLanguageTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserInformationWidget(
          user: user,
          onTapImageProfile: onTapImageProfile,
        ),
        const Expanded(child: SizedBox()),
        InkWell(
          onTap: onNotificationTapped,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: ColorSchemes.secondary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: badge.Badge(
                badgeContent: SizedBox(
                  child: notificationCount == 0
                      ? const SizedBox.shrink()
                      : Center(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: ColorSchemes.red,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(
                                  notificationCount > 99 ? 5 : 3),
                              child: Text(
                                notificationCount <= 999
                                    ? notificationCount.toString()
                                    : GetLanguageUseCase(injector())() == "ar"
                                        ? "999+"
                                        : "+999",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: ColorSchemes.white,
                                      fontSize:
                                          notificationCount > 99 ? 10 : 12,
                                      fontWeight: Constants.fontWeightBold,
                                    ),
                              ),
                            ),
                          ),
                        ),
                ),
                badgeAnimation: const badge.BadgeAnimation.scale(
                  animationDuration: Duration(milliseconds: 0),
                ),
                badgeStyle: badge.BadgeStyle(
                  badgeColor: Colors.transparent,
                  padding: notificationCount == 0
                      ? const EdgeInsets.all(0)
                      : const EdgeInsets.only(bottom: 16),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                position: badge.BadgePosition.topStart(
                  top: notificationCount > 99 ? -8 : -8,
                  start: notificationCount > 99 ? 10 : 12,
                ),
                child: SvgPicture.asset(
                  ImagePaths.notification,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        ),
        //change language button
        const SizedBox(width: 16),
        InkWell(
          onTap: onLanguageTapped,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: ColorSchemes.secondary,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.language,
                color: ColorSchemes.primary,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
