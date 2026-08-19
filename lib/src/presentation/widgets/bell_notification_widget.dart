import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/src/config/routes/routes_manager.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/usecase/get_language_use_case.dart';
import 'package:badges/badges.dart' as badge;

class BellNotificationWidget extends StatelessWidget {
  final int totalApprovals;

  const BellNotificationWidget({
    super.key,
    required this.totalApprovals,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.agreementsScreen,
            arguments: {"isShowBackButton": true},
          );
        },
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
                child: totalApprovals == 0
                    ? const SizedBox.shrink()
                    : Center(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: ColorSchemes.red,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.all(totalApprovals > 99 ? 5 : 3),
                            child: Text(
                              totalApprovals <= 999
                                  ? totalApprovals.toString()
                                  : GetLanguageUseCase(injector())() == "ar"
                                      ? "999+"
                                      : "+999",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: ColorSchemes.white,
                                    fontSize: totalApprovals > 99 ? 10 : 12,
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
                padding: totalApprovals == 0
                    ? const EdgeInsets.all(0)
                    : const EdgeInsets.only(bottom: 16),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              position: badge.BadgePosition.topStart(
                top: totalApprovals > 99 ? -8 : -8,
                start: totalApprovals > 99 ? 10 : 12,
              ),
              child: SvgPicture.asset(
                ImagePaths.notification,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
