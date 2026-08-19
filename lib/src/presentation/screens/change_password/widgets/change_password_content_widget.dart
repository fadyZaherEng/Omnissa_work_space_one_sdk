import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/presentation/widgets/custom_button_widget.dart';
import 'package:mofa/src/presentation/widgets/password_text_field_widget.dart';

class ChangePasswordContentWidget extends StatelessWidget {
  final Function() onBackButtonPressed;
  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final void Function(String value) onChangeOldPassword;
  final void Function(String value) onChangeNewPassword;
  final void Function(String value) onChangeConfirmPassword;
  final Function() changePasswordAction;
  final String? oldPasswordErrorMessage;
  final String? newPasswordErrorMessage;
  final String? confirmPasswordErrorMessage;

  const ChangePasswordContentWidget({
    super.key,
    required this.onBackButtonPressed,
    required this.oldPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.onChangeOldPassword,
    required this.onChangeNewPassword,
    required this.onChangeConfirmPassword,
    required this.changePasswordAction,
    this.oldPasswordErrorMessage,
    this.newPasswordErrorMessage,
    this.confirmPasswordErrorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchemes.secondary.withOpacity(0.028),
      appBar: buildAppBarWidget(
        context,
        title: S.of(context).changePassword,
        isHaveBackButton: true,
        onBackButtonPressed: onBackButtonPressed,
        centredTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(
              //   height: 30,
              // ),
              // PasswordTextFieldWidget(
              //   errorMessage: oldPasswordErrorMessage,
              //   controller: oldPasswordController,
              //   labelTitle: S.of(context).oldPassword,
              //   onChange: (value) => onChangeOldPassword(
              //     value,
              //   ),
              // ),
              const SizedBox(height: 24),
              Text(
                S
                    .of(context)
                    .theNewPasswordMustBeDifferentFromThePreviousPassword,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.primary,
                      letterSpacing: -0.24,
                      fontSize: 16,
                    ),
              ),
              const SizedBox(height: 16),
              PasswordTextFieldWidget(
                errorMessage: newPasswordErrorMessage,
                controller: newPasswordController,
                labelTitle: S.of(context).newPassword,
                onChange: (value) => onChangeNewPassword(value),
              ),
              const SizedBox(height: 32),
              PasswordTextFieldWidget(
                errorMessage: confirmPasswordErrorMessage,
                controller: confirmPasswordController,
                labelTitle: S.of(context).confirmPassword,
                onChange: (value) => onChangeConfirmPassword(value),
              ),
              const SizedBox(height: 48),
              CustomButtonWidget(
                width: double.infinity,
                height: 54,
                onTap: changePasswordAction,
                text: S.of(context).save,
                backgroundColor: ColorSchemes.primary,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
