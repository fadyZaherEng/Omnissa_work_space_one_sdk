import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/routes/routes_manager.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/base/widget/base_stateful_widget.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/presentation/screens/settings/skeleton/settings_skeleton.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/presentation/widgets/row_item_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends BaseStatefulWidget {
  const SettingsScreen({super.key});

  @override
  BaseState<SettingsScreen> baseCreateState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseState<SettingsScreen> {
  bool _showSkeleton = true;
  final bool _isAllowNotification = true;
  String appVersion = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showSkeleton = false;
      });
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    appVersion = (await PackageInfo.fromPlatform()).version;
  }

  @override
  Widget baseBuild(BuildContext context) {
    if (_showSkeleton) {
      return const SettingsSkeleton();
    }
    return Scaffold(
      backgroundColor: ColorSchemes.secondary,
      appBar: buildAppBarWidget(
        context,
        title: S.of(context).settings,
        isHaveBackButton: true,
        centredTitle: false,
        onBackButtonPressed: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
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
          // RowItemWidget(
          //   title: S.of(context).notificationsAndAlerts,
          //   path: ImagePaths.notificationSettings,
          //   onTap: () {},
          //   isAllowNotification: _isAllowNotification,
          //   isSwitch: true,
          //   onAllowNotification: (value) {
          //     setState(() {
          //       _isAllowNotification = value;
          //     });
          //   },
          // ),
          // RowItemWidget(
          //   title: S.of(context).changePassword,
          //   path: ImagePaths.lock,
          //   onTap: () {
          //     Navigator.pushNamed(context, Routes.changePasswordScreen);
          //   },
          // ),
          RowItemWidget(
            title: S.of(context).language,
            path: ImagePaths.language,
            onTap: () {
              Navigator.pushNamed(context, Routes.changeLanguageScreen);
            },
          ),
          RowItemWidget(
            title: S.of(context).version,
            path: ImagePaths.version,
            onTap: () {},
            text: appVersion,
          ),
          // RowItemWidget(
          //   title: S.of(context).deleteAccount,
          //   path: ImagePaths.delete,
          //   isDelete: true,
          //   isLast: true,
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }
}
