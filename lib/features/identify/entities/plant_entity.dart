class PlantEntity {
  final String scientificName;

  PlantEntity({required this.scientificName});

  factory PlantEntity.fromJson(Map<String, dynamic> json) {
    return PlantEntity(
      scientificName: json['scientificName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scientificName': scientificName,
    };
  }
}
