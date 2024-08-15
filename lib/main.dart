import 'package:flora_sense/app.dart';
import 'package:flora_sense/features/identify/service_locator.dart';
import 'package:flora_sense/features/network/network_service_locator.dart';
import 'package:flora_sense/features/theme/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

final GetIt serviceLocator = GetIt.instance;

void setupServiceLocators() {
  setupIdentifyLocator(serviceLocator);
  setupNetworkServiceLocator(serviceLocator);
  setupThemeServices(serviceLocator);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await dotenv.load(fileName: '.env');
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  setupServiceLocators();

  runApp(const App());
}
