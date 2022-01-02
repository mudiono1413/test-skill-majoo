import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_bloc_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState(isSignedIn: false)) ;
   void fetchHistoryLogin() async {
      emit(copyWith(isSignedIn: false));
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool isLoggedIn = sharedPreferences.getBool("is_logged_in") ?? false;
      emit(copyWith(isSignedIn: isLoggedIn));
    }
}
