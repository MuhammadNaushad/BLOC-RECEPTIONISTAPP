part of 'login_cubit.dart';

@immutable
class LoginState {}

class LoginInitial extends LoginState {
  final bool obscureText;
  LoginInitial({this.obscureText = true});
}

class TogglePasswordIcon extends LoginState {
  final bool obscureText;
  TogglePasswordIcon(this.obscureText);
}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {
  final dynamic data;

  LoginSuccess({this.data});
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}
