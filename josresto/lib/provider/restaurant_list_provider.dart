import 'package:flutter/material.dart';
import 'package:josresto/data/api/api_service.dart';
import 'package:josresto/static/restaurant_list_result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService _apiService;

  RestaurantListProvider(
    this._apiService,
  );

  RestaurantListResultState _resultState = RestaurantListNoneState();
  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchRestaurantList() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();
      final result = await _apiService.getRestaurantList();
      _resultState = RestaurantListLoadedState(result.restaurants);
    } catch (e) {
      _resultState = RestaurantListErrorState(
        "Gagal memuat data", // 🔹 Pastikan ini sesuai dengan yang diuji
      );
    }
    notifyListeners();
  }
}
