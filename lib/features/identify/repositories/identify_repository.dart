import 'package:flora_sense/features/identify/entities/plant_entity.dart';
import 'package:flora_sense/features/identify/providers/identify_provider.dart';

class IdentifyRepository {
  final IdentifyProvider identifyProvider;

  const IdentifyRepository({required this.identifyProvider});

  Future<PlantEntity> identify() async {
    return await identifyProvider.identify();
  }
}
