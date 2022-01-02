part of 'connection_cubit.dart';

class ConnectivityState extends Equatable {
  const ConnectivityState({required this.networkStatus});

  final bool networkStatus;
  @override
  // TODO: implement props
  List<Object?> get props => [networkStatus];
}

ConnectivityState copyWith({required bool networkStatus}) {
  return ConnectivityState(networkStatus: networkStatus);
}
