import 'dart:io';

import 'package:flora_sense/features/identify/entities/plant_entity.dart';
import 'package:flora_sense/features/identify/exceptions.dart';
import 'package:flora_sense/features/identify/repositories/identify_repository.dart';
import 'package:flora_sense/features/identify/services/camera_service.dart';

class PlantIdentificationService {
  final IdentifyRepository identifyRepositoryImpl;
  final CameraService cameraService;

  PlantIdentificationService(
      {required this.identifyRepositoryImpl, required this.cameraService});

  Future<PlantEntity?> identifyPlantFromCamera() async {
    final File? imageFile = await cameraService.takePicture();

    if (imageFile == null) {
      throw IdentifyEmptyImageException('Empty image');
    }

    final PlantEntity plant = await identifyRepositoryImpl.identify(imageFile);
    return plant;
  }
}
