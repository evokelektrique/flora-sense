import 'package:flora_sense/features/identify/entities/plant_entity.dart';

class IdentifyProvider {
  final String baseUrl;

  const IdentifyProvider({required this.baseUrl});

  Future<PlantEntity> identify() async {
    // final response ...
    await Future.delayed(Duration(seconds: 2));

    return PlantEntity.fromJson({'scientificName': 'Tesst'});
  }
}
