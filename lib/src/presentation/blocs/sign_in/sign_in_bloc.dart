import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/core/resources/data_state.dart';
import 'package:mofa/src/core/utils/constants.dart';
import 'package:mofa/src/core/utils/is_valid_email.dart';
import 'package:mofa/src/core/utils/validation/sign_in_validator.dart';
import 'package:mofa/src/data/sources/remote/mofa/login/request/request_login.dart';
import 'package:mofa/src/domain/entities/login/login.dart';
import 'package:mofa/src/domain/usecase/login/login_use_case.dart';
import 'package:mofa/src/domain/usecase/login/set_password_use_case.dart';
import 'package:mofa/src/domain/usecase/login/set_username_use_case.dart';
import 'package:mofa/src/domain/usecase/set_remember_me_use_case.dart';
import 'package:mofa/src/domain/usecase/set_token_use_case.dart';
import 'package:mofa/src/domain/usecase/sign_in_validation_use_case.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SetRememberMeUseCase _setRememberMeUseCase;
  final SignInValidationUseCase _signInValidationUseCase;
  final LoginUseCase _loginUseCase;
  final SetTokenUseCase _setTokenUseCase;
  final SetUserNameUseCase _setUserNameUseCase;

  final SetPasswordUseCase _setPasswordUseCase;

  SignInBloc(
      this._signInValidationUseCase,
      this._setRememberMeUseCase,
      this._loginUseCase,
      this._setTokenUseCase,
      this._setUserNameUseCase,
      this._setPasswordUseCase)
      : super(SignInInitialState()) {
    on<ExitAppEvent>(_onExitAppEvent);
    on<NavigateBackEvent>(_onNavigateBackEvent);
    on<SignInPressedEvent>(_onSignInPressedEvent);
    on<ChangeRememberMeValueEvent>(_onChangeRememberMeValueEvent);
    on<NavigateToForgotPasswordScreenEvent>(_onForgetPasswordEvent);
    on<ValidateEmailEvent>(_onValidateEmailEvent);
    on<ValidatePasswordEvent>(_onValidatePasswordEvent);
    on<SetRememberMeEvent>(_onSetRememberMeEvent);
    on<NavigateToHomeScreenEvent>(_onNavigateToHomeScreenEvent);
    on<SetRestartAppEvent>(_onSetRestartAppEvent);
  }

  FutureOr<void> _onExitAppEvent(
      ExitAppEvent event, Emitter<SignInState> emit) {
    emit(ExitAppState());
  }

  FutureOr<void> _onNavigateBackEvent(
      NavigateBackEvent event, Emitter<SignInState> emit) {
    emit(NavigateBackState());
  }

  FutureOr<void> _onSignInPressedEvent(
      SignInPressedEvent event, Emitter<SignInState> emit) async {
    final validationsState = _signInValidationUseCase.validateFormUseCase(
      email: event.email,
      password: event.password,
    );
    if (validationsState.isNotEmpty) {
      for (var element in validationsState) {
        if (element == SignInValidationState.emailEmpty ||
            element == SignInValidationState.emailFormatInvalid) {
          emit(EmailEmptyFormatState(
            emailValidatorMessage: event.email.isEmpty
                ? S.current.emailCantBeEmpty
                : (!isValidEmail(event.email)
                    ? S.current.emailLengthRequirement
                    : S.current.invalidEmail),
          ));
        } else if (element == SignInValidationState.passwordEmpty) {
          emit(PasswordEmptyFormatState(
              passwordValidatorMessage: S.current.thisFieldIsRequired));
        }
      }
      return;
    }
    emit(ShowLoadingState());
    //TODO Sign in Logic
    DataState<Login> loginResult = await _loginUseCase(
      requestLogin: RequestLogin(
        clientId: Constants.clientId,
        clientSecret: Constants.clientSecret,
        grantType: Constants.grantType,
        scope: Constants.scope,
        password: event.password.trim(),
        username: event.email.trim(),
      ),
    );
    if (loginResult is DataSuccess) {
      String newToken = "${loginResult.data?.accessToken}";
      await _setTokenUseCase(newToken);
      await _setUserNameUseCase(event.email);
      await _setPasswordUseCase(event.password);
      if (newToken.isNotEmpty) {
        debugPrint("newToken $newToken");
      }
      emit(SignInSuccessState());

      emit(HideLoadingState());
    } else {
      emit(HideLoadingState());
      emit(SignInErrorState(errorMessage: loginResult.message.toString()));
    }
  }

  FutureOr<void> _onChangeRememberMeValueEvent(
      ChangeRememberMeValueEvent event, Emitter<SignInState> emit) async {
    emit(ChangeRememberMeValueState(
      rememberMeValue: event.rememberMeValue,
    ));
  }

  FutureOr<void> _onForgetPasswordEvent(
      NavigateToForgotPasswordScreenEvent event, Emitter<SignInState> emit) {
    emit(NavigateToForgotPasswordScreenState());
  }

  FutureOr<void> _onValidateEmailEvent(
      ValidateEmailEvent event, Emitter<SignInState> emit) async {
    SignInValidationState validationState =
        _signInValidationUseCase.validateEmail(event.email);
    if (validationState == SignInValidationState.valid) {
      emit(EmailFormatValidState());
    } else if (validationState == SignInValidationState.emailFormatInvalid) {
      if (!isValidEmail(event.email)) {
        emit(
          EmailEmptyFormatState(
            emailValidatorMessage: S.current.emailLengthRequirement,
          ),
        );
      } else {
        emit(
          EmailEmptyFormatState(
            emailValidatorMessage:
                S.current.pleaseEnterAValidEmailAddressForExample,
          ),
        );
      }
    } else {
      emit(EmailEmptyFormatState(
        emailValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onValidatePasswordEvent(
      ValidatePasswordEvent event, Emitter<SignInState> emit) {
    SignInValidationState validationState =
        _signInValidationUseCase.validatePassword(
      event.password,
    );
    if (validationState == SignInValidationState.valid) {
      emit(PasswordFormatValidState());
    } else {
      emit(PasswordEmptyFormatState(
        passwordValidatorMessage: S.current.thisFieldIsRequired,
      ));
    }
  }

  FutureOr<void> _onSetRememberMeEvent(
      SetRememberMeEvent event, Emitter<SignInState> emit) async {
    final bool isSetRemember =
        await _setRememberMeUseCase(event.rememberMeValue);
    if (isSetRemember) {
      emit(SetRememberMeState());
    }
  }

  FutureOr<void> _onNavigateToHomeScreenEvent(
      NavigateToHomeScreenEvent event, Emitter<SignInState> emit) async {
    emit(NavigateToHomeScreenState());
  }

  Future<FutureOr<void>> _onSetRestartAppEvent(
      SetRestartAppEvent event, Emitter<SignInState> emit) async {
    emit(SetRestartAppState());
  }
}
