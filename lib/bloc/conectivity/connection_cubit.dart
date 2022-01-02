import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
part 'connectivity_state.dart';

class ConnectionCubit extends Cubit<ConnectivityState> {
  ConnectionCubit() : super(ConnectivityState(networkStatus: true));
  late InternetConnectionChecker internetConnectionChecker;
  StreamSubscription? internetConnectionStreamSubscription;
  void monitorInternetConnection() async {
    internetConnectionStreamSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          emit(copyWith(networkStatus: true));
          break;
        case InternetConnectionStatus.disconnected:
          emit(copyWith(networkStatus: false));
          break;
      }
    });
  }

  @override
  Future<void> close() async {
    internetConnectionStreamSubscription!.cancel();
    return super.close();
  }
}
