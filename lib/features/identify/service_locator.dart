import 'package:dio/dio.dart';
import 'package:flora_sense/features/identify/bloc/identify_bloc.dart';
import 'package:flora_sense/features/identify/repositories/identify_repository.dart';
import 'package:flora_sense/features/identify/services/identify_api_service.dart';
import 'package:flora_sense/features/identify/services/camera_service.dart';
import 'package:flora_sense/features/identify/services/plant_identification_service.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

void setupIdentifyLocator(GetIt serviceLocator) {
  serviceLocator.registerSingleton<Dio>(Dio());

  // Provider
  serviceLocator.registerLazySingleton<IdentifyApiService>(
      () => IdentifyApiService(dio: serviceLocator<Dio>()));

  // Repository
  serviceLocator.registerLazySingleton<IdentifyRepository>(() =>
      IdentifyRepository(
          identifyApiService: serviceLocator<IdentifyApiService>()));

  // Services
  serviceLocator.registerLazySingleton<CameraService>(
      () => CameraService(imagePicker: ImagePicker()));

  serviceLocator.registerLazySingleton<PlantIdentificationService>(
    () => PlantIdentificationService(
      identifyRepositoryImpl: serviceLocator<IdentifyRepository>(),
      cameraService: serviceLocator<CameraService>(),
    ),
  );

  // Bloc
  serviceLocator.registerLazySingleton<IdentifyBloc>(() => IdentifyBloc(
      plantIdentificationService: serviceLocator<PlantIdentificationService>(),
      identifyRepository: serviceLocator<IdentifyRepository>()));
}
