
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modal/modal.dart';


class PlanetProvider extends ChangeNotifier {
  PlanetModel? planetModel;
  List<String> favoritePlanetIds = [];

  Future<void> initPlanet() async {
    String json = await rootBundle.loadString('assets/json/planet.json');
    final response = jsonDecode(json);
    planetModel = PlanetModel.fromJson(response);
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    favoritePlanetIds = sharedPreferences.getStringList('favoritePlanetIds') ?? [];
  }

  PlanetProvider() {
    initPlanet();
    loadFavorites();
  }

  bool isFavorite(Planet planet) {
    return favoritePlanetIds.contains(planet.id);
  }

  void toggleFavorite(Planet planet) {
    if (isFavorite(planet)) {
      favoritePlanetIds.remove(planet.id);
    } else {
      favoritePlanetIds.add(planet.id);
    }
    _updateSharedPreferences();
    notifyListeners();
  }

  void removeFavorite(Planet planet) {
    favoritePlanetIds.remove(planet.id);
    _updateSharedPreferences();
    notifyListeners();
  }


  Future<void> _updateSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('favoritePlanetIds', favoritePlanetIds);
  }
}
