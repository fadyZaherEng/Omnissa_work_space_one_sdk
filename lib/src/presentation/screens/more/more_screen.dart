import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/routes/routes_manager.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/base/widget/base_stateful_widget.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/show_action_dialog_widget.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/entities/home/user_info.dart';
import 'package:mofa/src/domain/usecase/home/get_current_user_info_use_case.dart';
import 'package:mofa/src/domain/usecase/remove_remember_me_use_case.dart';
import 'package:mofa/src/presentation/screens/more/skeleton/more_skeleton.dart';
import 'package:mofa/src/presentation/screens/more/widgets/header_more_widget.dart';
import 'package:mofa/src/presentation/screens/profile/profile_screen.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/presentation/widgets/row_item_widget.dart';

class MoreScreen extends BaseStatefulWidget {
  const MoreScreen({super.key});

  @override
  BaseState<MoreScreen> baseCreateState() => _MoreScreenState();
}

class _MoreScreenState extends BaseState<MoreScreen> {
  bool showSkeleton = true;
  CurrentUserInfo currentUser = const CurrentUserInfo();

  @override
  void initState() {
    _getCurrentUserInfo();
    super.initState();
  }

  Future<void> _getCurrentUserInfo() async {
    final DataState<CurrentUserInfo> userInfo =
        await GetCurrentUserInfoUseCase(injector())();
    if (userInfo is DataSuccess) {
      currentUser = userInfo.data ?? const CurrentUserInfo();
      setState(() {
        showSkeleton = false;
      });
    } else {
      showSkeleton = false;
    }
  }

  @override
  Widget baseBuild(BuildContext context) {
    if (showSkeleton) {
      return const MoreSkeleton();
    }
    return Scaffold(
      backgroundColor: ColorSchemes.secondary,
      appBar: buildAppBarWidget(
        context,
        title: S.of(context).more,
        isHaveBackButton: false,
        actionWidget: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.settingsScreen,
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SvgPicture.asset(
              ImagePaths.settings,
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            HeaderMoreWidget(
              user: currentUser,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfileScreen(
                      userInfo: currentUser,
                    ),
                  ),
                );
                // showSnackBar(
                //   context: context,
                //   message: S.of(context).profile,
                //   color: ColorSchemes.primary,
                //   icon: ImagePaths.logo,
                // );
              },
              onProfileTap: (image) {},
            ),
            const SizedBox(height: 10),
            _buildMenuList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorSchemes.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          ..._menuItems(context),
        ],
      ),
    );
  }

  List<Widget> _menuItems(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      // {
      //   "title": S.of(context).strategies,
      //   "icon": ImagePaths.hierarchy,
      //   "onTap": () {
      //     Navigator.pushNamed(context, Routes.strategyScreen);
      //   },
      // },
      // {
      //   "title": S.of(context).initiatives,
      //   "icon": ImagePaths.clapping,
      //   "onTap": () {
      //     Navigator.pushNamed(context, Routes.initiativesScreen);
      //   },
      // },
      // {
      //   "title": S.of(context).projects,
      //   "icon": ImagePaths.project,
      //   "onTap": () {
      //     Navigator.pushNamed(
      //       context,
      //       Routes.projectsScreen,
      //       arguments: {"isShowBackButton": true},
      //     );
      //   },
      // },
      // {
      //   "title": S.of(context).pointersTool,
      //   "icon": ImagePaths.pointer,
      //   "onTap": () {
      //     Navigator.pushNamed(
      //       context,
      //       Routes.pointersScreen,
      //       arguments: {"isShowBackButton": true},
      //     );
      //   },
      // },
      // {
      //   "title": S.of(context).tasks,
      //   "icon": ImagePaths.task,
      //   "onTap": () {
      //     Navigator.pushNamed(
      //       context,
      //       Routes.tasksScreen,
      //       arguments: {"isShowBackButton": true},
      //     );
      //   },
      // },
      // {
      //   "title": S.of(context).deliverables,
      //   "icon": ImagePaths.task,
      //   "onTap": () {
      //     Navigator.pushNamed(
      //       context,
      //       Routes.deliverablesScreen,
      //       arguments: {"isShowBackButton": true},
      //     );
      //   },
      // },
      // {
      //   "title": S.of(context).milstones,
      //   "icon": ImagePaths.task,
      //   "onTap": () {
      //     Navigator.pushNamed(
      //       context,
      //       Routes.milstonesScreen,
      //       arguments: {"isShowBackButton": true},
      //     );
      //   },
      // },
      {
        "title": S.of(context).agreements,
        "icon": ImagePaths.checkMark,
        "onTap": () {
          Navigator.pushNamed(context, Routes.agreementsScreen);
        },
      },
      // {
      //   "title": S.of(context).risks,
      //   "icon": ImagePaths.risks,
      //   "onTap": () {
      //     Navigator.pushNamed(
      //       context,
      //       Routes.risksScreen,
      //       arguments: {"isShowBackButton": true},
      //     );
      //   },
      // },
      // {
      //   "title": S.of(context).challenges,
      //   "icon": ImagePaths.challenges,
      //   "onTap": () {
      //     Navigator.pushNamed(
      //       context,
      //       Routes.challengesScreen,
      //       arguments: {"isShowBackButton": true},
      //     );
      //   },
      // },
      // {
      //   "title": S.of(context).logout,
      //   "icon": ImagePaths.logout,
      //   "onTap": _onLogoutTap,
      // },
    ];

    return items
        .asMap()
        .entries
        .map(
          (entry) => RowItemWidget(
            path: entry.value['icon'] as String,
            onTap: entry.value['onTap'] as VoidCallback,
            title: entry.value['title'] as String,
            isLast: entry.key == items.length - 1,
          ),
        )
        .toList();
  }

  void _onLogoutTap() async {
    showActionDialogWidget(
      context: context,
      text: S.of(context).areYouSureYouWantLogoutMovaApp,
      icon: ImagePaths.logout,
      primaryText: S.of(context).no,
      secondaryText: S.of(context).yes,
      primaryAction: () => Navigator.pop(context),
      secondaryAction: () async {
        bool result = await RemoveRememberMeUseCase(injector())();
        if (result) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.signIn,
            (Route<dynamic> route) => false,
          );
        }
      },
    );
  }
}
