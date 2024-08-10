import 'package:flora_sense/features/network/bloc/network_bloc.dart';
import 'package:flora_sense/main.dart';

class NetworkHelper {
  static final NetworkBloc _networkBloc = serviceLocator<NetworkBloc>();


  static bool checkInternetConnection()  {
    final currentState = _networkBloc.state;

    if (currentState is NetworkConnected) {
      return true;
    } else if (currentState is NetworkDisconnected) {
      return false;
    } else {
      return false;
    }
  }

  static Future<bool> checkInternetConnectionAsync() async {
    final currentState = _networkBloc.state;

    if (currentState is NetworkConnected) {
      return true;
    } else if (currentState is NetworkDisconnected) {
      return false;
    } else {
      return Future.value(false);
    }
  }
}
