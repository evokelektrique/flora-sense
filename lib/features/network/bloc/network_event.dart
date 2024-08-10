part of 'network_bloc.dart';

sealed class NetworkEvent extends Equatable {
  const NetworkEvent();

  @override
  List<Object> get props => [];
}

class NetworkStatusChanged extends NetworkEvent {
  final bool isConnected;

  const NetworkStatusChanged({required this.isConnected});

  @override
  List<Object> get props => [isConnected];
}