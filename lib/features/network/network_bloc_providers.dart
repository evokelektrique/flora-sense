import 'package:flora_sense/features/network/bloc/network_bloc.dart';
import 'package:flora_sense/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> buildNetworkBlocProviders() {
  return [
    BlocProvider<NetworkBloc>(create: (_) => serviceLocator<NetworkBloc>()),
  ];
}
