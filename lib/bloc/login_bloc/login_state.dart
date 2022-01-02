part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email ="",
    this.password = "",
    this.status = FormzStatus.pure,
    this.exceptionError = "",
  });

  final String email;
  final String password;
  final FormzStatus status;
  final String exceptionError;

  @override
  List<Object> get props => [email, password, status, exceptionError];

  LoginState copyWith({
    String? email,
    String? password,
    FormzStatus? status,
    String? exceptionError,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      exceptionError: exceptionError ?? this.exceptionError,
    );
  }
}
