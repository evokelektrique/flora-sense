import 'package:flora_sense/features/identify/bloc/identify_bloc.dart';
import 'package:flora_sense/features/identify/providers/identify_provider.dart';
import 'package:flora_sense/features/identify/repositories/identify_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

void setupIdentifyLocator(GetIt serviceLocator) {
  // Provider
  serviceLocator.registerLazySingleton<IdentifyProvider>(
      () => IdentifyProvider(baseUrl: dotenv.env['BASE_URL'] ?? ''));

  // Repository
  serviceLocator.registerLazySingleton<IdentifyRepository>(() =>
      IdentifyRepository(identifyProvider: serviceLocator<IdentifyProvider>()));

  // Bloc
  serviceLocator.registerLazySingleton<IdentifyBloc>(() => IdentifyBloc(serviceLocator<IdentifyRepository>()));
}
