import 'package:flora_sense/features/identify/bloc/identify_bloc.dart';
import 'package:flora_sense/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider<dynamic>> buildIdentifyBlocProviders() {
  return [
    BlocProvider<IdentifyBloc>(
      create: (_) => serviceLocator<IdentifyBloc>(),
    ),
  ];
}