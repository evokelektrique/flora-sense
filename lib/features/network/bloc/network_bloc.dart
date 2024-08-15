import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final Connectivity _connectivity;

  NetworkBloc(this._connectivity) : super(NetworkDisconnected()) {
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
      final bool isConnected = result.contains(ConnectivityResult.none) ? false : true;
      add(NetworkStatusChanged(isConnected: isConnected));
    });

    on<NetworkStatusChanged>(_onNetworkStatusChanged);
  }

  void _onNetworkStatusChanged(
      NetworkStatusChanged event, Emitter<NetworkState> emit) {
    event.isConnected ? emit(NetworkConnected()) : emit(NetworkDisconnected());
  }
}
