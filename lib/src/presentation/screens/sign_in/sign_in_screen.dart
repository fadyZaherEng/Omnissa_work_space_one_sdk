import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/routes/routes_manager.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/base/widget/base_stateful_widget.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/show_action_dialog_widget.dart';
import 'package:mofa/src/core/utils/show_massage_dialog_widget.dart';
import 'package:mofa/src/presentation/blocs/sign_in/sign_in_bloc.dart';
import 'package:mofa/src/presentation/screens/sign_in/widgets/header_widget.dart';
import 'package:mofa/src/presentation/screens/sign_in/widgets/remember_me_widget.dart';
import 'package:mofa/src/presentation/widgets/custom_button_widget.dart';
import 'package:mofa/src/presentation/widgets/custom_text_field_widget.dart';
import 'package:mofa/src/presentation/widgets/password_text_field_widget.dart';
import 'package:mofa/src/presentation/widgets/restart_widget.dart';
import 'package:mofa/core/services/secure_screen_wrapper.dart';
import 'package:mofa/core/services/workspace_one_security_mixin.dart';

class SignInScreen extends BaseStatefulWidget {
  const SignInScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _SignInScreenState();
}

class _SignInScreenState extends BaseState<SignInScreen>
    with WidgetsBindingObserver, WorkspaceOneSecurityMixin {
  SignInBloc get _bloc => BlocProvider.of<SignInBloc>(context);
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailErrorMessage;
  String? _passwordErrorMessage;
  bool _isCheckRememberMe = false;
  bool _isDebouncing = false;

  @override
  void initState() {
    super.initState();
    _init();
    performSecurityChecks(); // فحص أمان WS1
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _scrollToBottomScreenWhenKeyboardOpen();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return SecureScreenWrapper(
      child: BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is ShowLoadingState) {
          showLoading();
        } else if (state is HideLoadingState) {
          hideLoading();
        } else if (state is ExitAppState) {
          _showExitAppDialog();
        } else if (state is NavigateBackState) {
          _navigateBack();
        } else if (state is EmailEmptyFormatState) {
          _emailErrorMessage = state.emailValidatorMessage;
        } else if (state is EmailFormatValidState) {
          _emailErrorMessage = null;
        } else if (state is PasswordEmptyFormatState) {
          _passwordErrorMessage = state.passwordValidatorMessage;
        } else if (state is PasswordFormatValidState) {
          _passwordErrorMessage = null;
        } else if (state is ChangeRememberMeValueState) {
          _isCheckRememberMe = state.rememberMeValue;
        } else if (state is NavigateToForgotPasswordScreenState) {
          if (_isCheckRememberMe) {
            _bloc.add(ChangeRememberMeValueEvent(rememberMeValue: false));
          }
          _navigateToForgotPasswordScreen();
        } else if (state is SignInSuccessState) {
          _setRememberMeValueEvent();
          _navigateToMainScreen();
        } else if (state is SignInErrorState) {
          _showMessageDialog(
            message: state.errorMessage,
            icon: ImagePaths.error,
            iconColor: ColorSchemes.red,
            onTap: () {
              _navigateBackEvent();
            },
          );
        } else if (state is SetRestartAppState) {
          RestartWidget.restartApp(context);
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: true,
          onPopInvoked: (value) => _exitAppEvent,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              ImagePaths.loginBackground,
                              width: 128,
                              height: 250,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 64),
                              child: HeaderWidget(),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).welcomeBack,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: ColorSchemes.black,
                                      fontSize: 26,
                                      letterSpacing: -0.26,
                                      fontWeight: Constants.fontWeightBold,
                                    ),
                              ),
                              const SizedBox(width: 16),
                              // SvgPicture.asset(
                              //   ImagePaths.hi,
                              //   width: 32,
                              //   height: 32,
                              //   fit: BoxFit.scaleDown,
                              // )
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              CustomTextFieldWidget(
                                textInputType: TextInputType.emailAddress,
                                errorMessage: _emailErrorMessage,
                                controller: _emailController,
                                labelTitle: S.of(context).emailAddress,
                                onChange: (value) => _validateEmailEvent(value),
                                enableInteractiveSelection: isCopyPasteAllowed,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z0-9@._-]'))
                                ],
                              ),
                              const SizedBox(height: 20),
                              PasswordTextFieldWidget(
                                errorMessage: _passwordErrorMessage,
                                controller: _passwordController,
                                labelTitle: S.of(context).password,
                                onChange: _validatePasswordEvent,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RememberMeWidget(
                                    isCheckRememberMe: _isCheckRememberMe,
                                    onTap: () => _changeRememberMeEvent(
                                        _isCheckRememberMe),
                                    onChange: _changeRememberMeEvent,
                                  ),
                                  GestureDetector(
                                    onTap: _navigateToForgotPasswordScreenEvent,
                                    child: Text(
                                      S.of(context).forgetPasswordForSignIn,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: ColorSchemes.primary,
                                            letterSpacing: -0.13,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              CustomButtonWidget(
                                width: double.infinity,
                                onTap: _signInEvent,
                                text: S.of(context).signIn,
                                backgroundColor: ColorSchemes.primary,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: ColorSchemes.white,
                                      letterSpacing: -0.13,
                                      fontWeight: Constants.fontWeightBold,
                                    ),
                              ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
    );
  }

  void _setRememberMeValueEvent() {
    _bloc.add(SetRememberMeEvent(rememberMeValue: _isCheckRememberMe));
  }

  void _navigateToMainScreen() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.main,
      (Route<dynamic> route) => false,
    );
  }

  void _changeRememberMeEvent(bool value) {
    _bloc.add(ChangeRememberMeValueEvent(rememberMeValue: value));
  }

  void _navigateToForgotPasswordScreenEvent() {
    _bloc.add(NavigateToForgotPasswordScreenEvent());
  }

  void _init() async {
    WidgetsBinding.instance.addObserver(this);
  }

  void _scrollToBottomScreenWhenKeyboardOpen() {
    final isKeyboardOpen =
        WidgetsBinding.instance.window.viewInsets.bottom != 0.0;
    if (isKeyboardOpen) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showMessageDialog({
    required String message,
    required String icon,
    required Function() onTap,
    Color? iconColor,
  }) {
    showMassageDialogWidget(
      context: context,
      text: message,
      icon: icon,
      iconColor: iconColor,
      buttonText: S.of(context).ok,
      onTap: onTap,
    );
  }

  void _validatePasswordEvent(String value) {
    _bloc.add(ValidatePasswordEvent(password: value));
  }

  void _validateEmailEvent(String email) {
    _bloc.add(ValidateEmailEvent(email: email));
  }

  void _signInEvent() {
    if (!_isDebouncing) {
      setState(() {
        _isDebouncing = true;
      });

      _bloc.add(
        SignInPressedEvent(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );

      Timer(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isDebouncing = false;
          });
        }
      });
    }
  }

  void _navigateBackEvent() => _bloc.add(NavigateBackEvent());

  void _exitAppEvent() => _bloc.add(ExitAppEvent());

  void _showExitAppDialog() {
    showActionDialogWidget(
        context: context,
        text: S.of(context).areYouSureYouWantExitMovaApp,
        icon: ImagePaths.warning,
        primaryText: S.of(context).no,
        secondaryText: S.of(context).yes,
        primaryAction: _navigateBackEvent,
        secondaryAction: () async => exit(0));
  }

  void _navigateToForgotPasswordScreen() {
    // Navigator.pushNamed(context, Routes.forgetPassword);
  }

  void _navigateBack() => Navigator.pop(context);

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
  }
}
