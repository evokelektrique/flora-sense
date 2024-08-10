import 'package:flora_sense/app.dart';
import 'package:flora_sense/features/identify/identify_service_locator.dart';
import 'package:flora_sense/features/network/network_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocators() {
  setupIdentifyLocator(serviceLocator);
  setupNetworkServiceLocator(serviceLocator);
}

Future<void> main() async {
  // Load environment variables
  await dotenv.load(fileName: '.env');

  setupServiceLocators();

  runApp(App());
}
