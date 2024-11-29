
class PlanetModel {
  late int total;
  late List<Planet> planets;

  PlanetModel({required this.total, required this.planets});

  factory PlanetModel.fromJson(Map<String, dynamic> m1) {
    return PlanetModel(
      total: m1['total'] ?? 0,
      planets: (m1['planets'] as List)
          .map((planetJson) => Planet.fromJson(planetJson))
          .toList(),
    );
  }
}

class Planet {
  late String id, name, description, image, distanceFromSun, gravity,short_des,diameter;
  late int moons;
  late bool favorite;

  Planet({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.distanceFromSun,
    required this.gravity,
    required this.moons,
    required this.favorite,
    required this.short_des,
    required this.diameter
  });

  factory Planet.fromJson(Map<String, dynamic> m1) {
    return Planet(
      id: m1['id'] ?? '',
      name: m1['name'] ?? 'Unknown',
      description: m1['description'] ?? 'No description available',
      image: m1['image'] ?? '',
      distanceFromSun: m1['distance_from_sun'] ?? 'Unknown',
      gravity: m1['gravity'] ?? 'Unknown',
      moons: m1['moons'] ?? 0,
      favorite: m1['favorite'] ?? false,
      short_des: m1['short_des'],
      diameter: m1['diameter']?? 'Unknown',
    );
  }
}
