import 'package:flora_sense/features/theme/cubit/theme_cubit.dart';
import 'package:flora_sense/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> buildThemeBlocProviders() {
  return [
    BlocProvider<ThemeCubit>(
      create: (_) => serviceLocator<ThemeCubit>(),
    )
  ];
}
