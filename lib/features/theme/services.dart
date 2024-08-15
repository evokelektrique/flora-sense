import 'package:flora_sense/features/theme/cubit/theme_cubit.dart';
import 'package:get_it/get_it.dart';

void setupThemeServices(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}