part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.email = "",
    this.password = "",
    this.name = "",
    this.status = FormzStatus.pure,
    this.exceptionError = "",
  });

  final String email;
  final String name;
  final String password;
  final FormzStatus status;
  final String exceptionError;

  @override
  List<Object> get props => [email, name, password, status, exceptionError];

  SignUpState copyWith({
    String? email,
    String? name,
    String? password,
    FormzStatus? status,
    String? exceptionError,
  }) {
    return SignUpState(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      status: status ?? this.status,
      exceptionError: exceptionError ?? this.exceptionError,
    );
  }
}
