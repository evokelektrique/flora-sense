import 'dart:io';

import 'package:flora_sense/features/identify/entities/plant_entity.dart';
import 'package:flora_sense/features/identify/services/identify_api_service.dart';

class IdentifyRepository {
  final IdentifyApiService identifyApiService;

  const IdentifyRepository({required this.identifyApiService});

  Future<PlantEntity> identify(File imageFile) async {
    return await identifyApiService.identify(imageFile);
  }

  Future<bool> serverStatus() async {
    return await identifyApiService.serverStatus();
  }
}
