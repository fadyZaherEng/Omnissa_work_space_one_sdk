import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/base/widget/base_stateful_widget.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/show_snack_bar.dart';
import 'package:mofa/src/di/data_layer_injector.dart';
import 'package:mofa/src/domain/usecase/get_language_use_case.dart';
import 'package:mofa/src/domain/usecase/set_language_use_case.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/presentation/widgets/custom_button_widget.dart';
import 'package:mofa/src/presentation/widgets/restart_widget.dart';

class ChangeLanguageScreen extends BaseStatefulWidget {
  final bool isBottomSheet;

  const ChangeLanguageScreen({
    super.key,
    this.isBottomSheet = false,
  });

  @override
  BaseState<BaseStatefulWidget> baseCreateState() =>
      _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends BaseState<ChangeLanguageScreen> {
  bool _isEnglish = false;

  @override
  void initState() {
    super.initState();
    _isEnglish = GetLanguageUseCase(injector())() == 'en';
  }

  @override
  Widget baseBuild(BuildContext context) {
    return widget.isBottomSheet
        ? _buildBody(context)
        : Scaffold(
            backgroundColor: ColorSchemes.secondary.withOpacity(0.028),
            appBar: buildAppBarWidget(
              context,
              title: S.of(context).language,
              centredTitle: false,
              isHaveBackButton: true,
              onBackButtonPressed: () => Navigator.pop(context),
            ),
            body: _buildBody(context),
          );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Padding(
        padding:widget.isBottomSheet ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (!widget.isBottomSheet)
            const SizedBox(height: 24),
            if (!widget.isBottomSheet)
            Text(
              S.of(context).ChooseYourPreferredLanguage,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorSchemes.primary,
                    letterSpacing: -0.24,
                    fontSize: 16,
                  ),
            ),
             const SizedBox(height: 16),
            _buildLanguageItem(
              context,
              S.of(context).arabic,
              ImagePaths.language,
              () {
                setState(() {
                  _isEnglish = false;
                });
              },
              color: !_isEnglish ? ColorSchemes.secondary : ColorSchemes.white,
              borderColor:
                  !_isEnglish ? ColorSchemes.primary : ColorSchemes.border,
              isEnglish: false,
            ),
            const SizedBox(height: 24),
            _buildLanguageItem(
              context,
              S.of(context).english,
              ImagePaths.language,
              () {
                setState(() {
                  _isEnglish = true;
                });
              },
              color: _isEnglish ? ColorSchemes.secondary : ColorSchemes.white,
              borderColor:
                  _isEnglish ? ColorSchemes.primary : ColorSchemes.border,
              isEnglish: true,
            ),
            (widget.isBottomSheet)?
              const SizedBox(height: 24):
            const SizedBox(height: 48),
            CustomButtonWidget(
              width: double.infinity,
              height: 54,
              onTap: () async {
                SetLanguageUseCase(injector())(_isEnglish ? 'en' : 'ar');
                showSnackBar(
                  context: context,
                  message: S.of(context).changeLanguageSuccessfully,
                  color: ColorSchemes.primary,
                  icon: ImagePaths.right,
                );
                await Future.delayed(const Duration(milliseconds: 500));
                RestartWidget.restartApp(context);
              },
              text: S.of(context).continues,
              backgroundColor: ColorSchemes.primary,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageItem(
    BuildContext context,
    String text,
    String language,
    void Function() onTap, {
    required Color color,
    required Color borderColor,
    required bool isEnglish,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 54,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: 0.75,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isEnglish ? text : "Arabic",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorSchemes.black,
                    letterSpacing: -0.24,
                    fontSize: 15,
                    fontWeight: Constants.fontWeightSemiBold,
                  ),
            ),
            const Spacer(),
            Text(
              isEnglish ? "English" : text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorSchemes.black,
                    letterSpacing: -0.24,
                    fontWeight: Constants.fontWeightSemiBold,
                    fontSize: 15,
                  ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              ImagePaths.language,
              width: 24,
              height: 24,
              color: ColorSchemes.black,
            )
          ],
        ),
      ),
    );
  }
}
