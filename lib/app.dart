import 'package:flora_sense/features/identify/identify_bloc_providers.dart';
import 'package:flora_sense/features/identify/screen/identify_screen.dart';
import 'package:flora_sense/features/network/network_bloc_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ...buildIdentifyBlocProviders(),
        ...buildNetworkBlocProviders(),
      ],
      child: materialApp(),
    );
  }

  MaterialApp materialApp() {
    return MaterialApp(
      title: 'Plant Identification',
      routes: {
        '/': (context) => IdentifyScreen(),
      },
    );
  }
}
