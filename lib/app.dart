import 'package:flora_sense/constants/theme_constants.dart';
import 'package:flora_sense/features/identify/bloc_providers.dart';
import 'package:flora_sense/features/identify/screens/identify_screen.dart';
import 'package:flora_sense/features/network/network_bloc_providers.dart';
import 'package:flora_sense/features/theme/bloc_providers.dart';
import 'package:flora_sense/features/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ...buildIdentifyBlocProviders(),
        ...buildNetworkBlocProviders(),
        ...buildThemeBlocProviders(),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return materialApp(themeMode);
        },
      ),
    );
  }

  MaterialApp materialApp(ThemeMode themeMode) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant Identification',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: themeMode,
      routes: {
        '/': (context) => IdentifyScreen(),
      },
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: darkModePalette.primary,
        brightness: Brightness.dark,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkModePalette.appBarBackground,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: darkModePalette.background,
      iconTheme: IconThemeData(
        color: darkModePalette.iconColor,
      ),
      textTheme: const TextTheme(
        bodyMedium: textStyleDarkMode,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: darkModePalette.snackBarBackground,
        actionTextColor: darkModePalette.snackBarActionColor,
        contentTextStyle:
            TextStyle(color: darkModePalette.snackBarContentColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: lightModePalette.primary,
        brightness: Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: lightModePalette.secondary,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      scaffoldBackgroundColor: lightModePalette.background,
      iconTheme: IconThemeData(
        color: lightModePalette.iconColor,
      ),
      textTheme: const TextTheme(
        bodyMedium: textStyleLightMode,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: lightModePalette.snackBarBackground,
        actionTextColor: lightModePalette.snackBarActionColor,
        contentTextStyle:
            TextStyle(color: lightModePalette.snackBarContentColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
