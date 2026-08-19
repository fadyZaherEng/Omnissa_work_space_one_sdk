import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/flavors.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/routes/routes_manager.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/base/widget/base_stateful_widget.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/resources/shared_preferences_keys.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/usecase/clear_local_data_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';
import 'package:mofa/core/services/workspace_one_service.dart';

class SplashScreen extends BaseStatefulWidget {
  final String versionCode;

  const SplashScreen({
    super.key,
    required this.versionCode,
  });

  @override
  SplashScreenState baseCreateState() => SplashScreenState();
}

class SplashScreenState extends BaseState<SplashScreen> {
  late bool _isRememberMe;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    _isRememberMe = prefs.getBool(SharedPreferenceKeys.rememberMe) ?? false;
    _handleUserNavigation();
  }

  Future<void> _handleUserNavigation() async {
    await Future.delayed(const Duration(seconds: 2));

    // فحص أمان الجهاز (هل الجهاز مكسور الحماية Root/Jailbreak)
    final isCompromised = await WorkspaceOneService.instance.checkIsCompromised();
    if (isCompromised && mounted) {
      _showSecurityWarningDialog();
      return;
    }

    if (_isRememberMe) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, Routes.main);
      }
    } else {
      await ClearLocalDataUseCase(injector())();

      if (mounted) {
        Navigator.pushReplacementNamed(context, Routes.signIn);
      }
    }
  }

  void _showSecurityWarningDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("تحذير أمني"),
        content: const Text(
          "تم اكتشاف كسر حماية في نظام هذا الجهاز (Root/Jailbreak). لا يمكن تشغيل التطبيق حفاظاً على أمان البيانات.",
        ),
        actions: [
          TextButton(
            onPressed: () => exit(0),
            child: const Text("إغلاق التطبيق"),
          ),
        ],
      ),
    );
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImagePaths.logo,
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${S.of(context).poweredBy}  ",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: ColorSchemes.gray,
                        letterSpacing: -0.24,
                      ),
                ),
                Text(
                  F.title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: ColorSchemes.black,
                        letterSpacing: -0.24,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.versionCode,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: ColorSchemes.gray,
                    letterSpacing: -0.24,
                  ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
