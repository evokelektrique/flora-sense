import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flora_sense/features/network/bloc/network_bloc.dart';
import 'package:get_it/get_it.dart';

void setupNetworkServiceLocator(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<Connectivity>(() => Connectivity());

  serviceLocator.registerLazySingleton<NetworkBloc>(
      () => NetworkBloc(serviceLocator<Connectivity>()));
}
