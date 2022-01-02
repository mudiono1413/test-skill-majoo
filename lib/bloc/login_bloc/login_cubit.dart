import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:majootestcase/DB/db_helper.dart';
import 'package:majootestcase/models/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  final DbHelper db = DbHelper();
  void loginUser(User user) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    await db.getUser(user).then((value) {
      print("hjjgjgjgj " + value.email.toString());
      if (value.email != null) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess, email: value.email));
      } else {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure, exceptionError: "Login gagal , periksa kembali inputan anda"));
      }
    });
  }
}
