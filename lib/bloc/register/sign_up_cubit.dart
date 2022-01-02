import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:majootestcase/DB/db_helper.dart';
import 'package:majootestcase/models/user.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

   final DbHelper db = DbHelper();

  void register(User user) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    db.saveUser(user).then((value) {
      print("callbacj " + value.toString());
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    });
  }
}
