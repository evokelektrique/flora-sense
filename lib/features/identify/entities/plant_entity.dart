class PlantEntity {
  final String scientificNameWithoutAuthor;
  final String name;
  final double score;

  PlantEntity(
      {required this.name,
      required this.score,
      required this.scientificNameWithoutAuthor});

  factory PlantEntity.fromJson(Map<String, dynamic> json) {
    return PlantEntity(
      scientificNameWithoutAuthor: json['scientificNameWithoutAuthor'],
      score: json['score'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scientificNameWithoutAuthor': scientificNameWithoutAuthor,
      'score': score,
      'name': name,
    };
  }
}
