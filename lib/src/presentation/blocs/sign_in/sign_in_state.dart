part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SignInInitialState extends SignInState {}

class ShowLoadingState extends SignInState {}

class HideLoadingState extends SignInState {}

class ExitAppState extends SignInState {}

class NavigateBackState extends SignInState {}

class SignInSuccessState extends SignInState {}

class SignInErrorState extends SignInState {
  final String errorMessage;

  SignInErrorState({
    required this.errorMessage,
  });
}

class ChangeRememberMeValueState extends SignInState {
  final bool rememberMeValue;

  ChangeRememberMeValueState({
    required this.rememberMeValue,
  });
}

class NavigateToForgotPasswordScreenState extends SignInState {}

class EmailEmptyFormatState extends SignInState {
  final String emailValidatorMessage;

  EmailEmptyFormatState({
    required this.emailValidatorMessage,
  });
}

class PasswordEmptyFormatState extends SignInState {
  final String passwordValidatorMessage;

  PasswordEmptyFormatState({
    required this.passwordValidatorMessage,
  });
}

class EmailFormatValidState extends SignInState {}

class PasswordFormatValidState extends SignInState {}

class ValidSignInFormState extends SignInState {
  final String email;
  final String password;

  ValidSignInFormState({
    required this.email,
    required this.password,
  });
}

class SetRememberMeState extends SignInState {}

class NavigateToHomeScreenState extends SignInState {}

class SetRestartAppState extends SignInState {}
