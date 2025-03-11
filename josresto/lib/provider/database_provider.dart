import 'package:flutter/material.dart';
import 'package:josresto/data/model/restaurant.dart';
import 'package:josresto/services/sqlite_service.dart';

class DatabaseProvider extends ChangeNotifier {
  final SqliteService _service;

  DatabaseProvider(this._service) {
    _initLoadFavorites();
  }

  Future<void> _initLoadFavorites() async {
    await loadAllRestaurantValue();
  }

  String _message = "";
  String get message => _message;

  List<Restaurant> _restaurantList = [];
  List<Restaurant> get restaurantList => _restaurantList;

  Restaurant? _restaurant;
  Restaurant? get restaurant => _restaurant;

  void _setMessage(String msg) {
    _message = msg;
    notifyListeners();
  }

  Future<void> toggleFavorite(Restaurant restaurant) async {
    try {
      final isFavorite =
          _restaurantList.any((item) => item.id == restaurant.id);

      if (isFavorite) {
        await removeRestaurantValueById(restaurant.id);
      } else {
        await saveRestaurantValue(restaurant);
      }

      await loadAllRestaurantValue();
    } catch (e) {
      _setMessage("Failed to update favorite status");
      debugPrint("Error in toggleFavorite: $e");
    }
  }

  Future<void> saveRestaurantValue(Restaurant restaurant) async {
    try {
      final result = await _service.insertFavorite(restaurant);
      if (result > 0) {
        _setMessage("Your data is saved");
        await loadAllRestaurantValue();
      } else {
        _setMessage("Failed to save your data");
      }
    } catch (e) {
      _setMessage("Failed to save your data");
      debugPrint("Error in saveRestaurantValue: $e");
    }
  }

  Future<void> loadAllRestaurantValue() async {
    try {
      _restaurantList = await _service.getFavorites();
      _setMessage("All of your data is loaded");
      notifyListeners();
    } catch (e) {
      _setMessage("Failed to load your data");
      debugPrint("Error in loadAllRestaurantValue: $e");
    }
  }

  Future<void> removeRestaurantValueById(String id) async {
    try {
      final result = await _service.removeItem(id);
      if (result > 0) {
        _setMessage("Your data is removed");
        await loadAllRestaurantValue();
      } else {
        _setMessage("Failed to remove your data");
      }
    } catch (e) {
      _setMessage("Failed to remove your data");
      debugPrint("Error in removeRestaurantValueById: $e");
    }
  }
}
