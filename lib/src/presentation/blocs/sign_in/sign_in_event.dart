part of 'sign_in_bloc.dart';

@immutable
class SignInEvent extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ExitAppEvent extends SignInEvent {}

class NavigateBackEvent extends SignInEvent {}

class SignInPressedEvent extends SignInEvent {
  final String email;
  final String password;

  SignInPressedEvent({
    required this.email,
    required this.password,
  });
}

class ChangeRememberMeValueEvent extends SignInEvent {
  final bool rememberMeValue;

  ChangeRememberMeValueEvent({
    required this.rememberMeValue,
  });
}

class NavigateToForgotPasswordScreenEvent extends SignInEvent {}

class ValidateEmailEvent extends SignInEvent {
  final String email;

  ValidateEmailEvent({
    required this.email,
  });
}

class ValidatePasswordEvent extends SignInEvent {
  final String password;

  ValidatePasswordEvent({
    required this.password,
  });
}

final class SetRememberMeEvent extends SignInEvent {
  final bool rememberMeValue;

  SetRememberMeEvent({
    required this.rememberMeValue,
  });
}

class NavigateToHomeScreenEvent extends SignInEvent {
  NavigateToHomeScreenEvent();
}

class SetRestartAppEvent extends SignInEvent {}
