part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, error }

class LoginState extends Equatable {
  final LoginStatus loginStatus;
  final String message;
  final String email;
  final String password;

  const LoginState({
    this.email = '',
    this.password = '',
    this.message = '',
    this.loginStatus = LoginStatus.initial,
  });

  @override
  List<Object?> get props => [loginStatus, message, email, password];

  LoginState copyWith({
    LoginStatus? loginStatus,
    String? message,
    String? email,
    String? password,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      message: message ?? this.message,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
