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
      if (result.error) {
        _resultState = RestaurantListErrorState(result.message);
      } else {
        _resultState = RestaurantListLoadedState(result.restaurants);
      }
    } on Exception catch (e) {
      _resultState = RestaurantListErrorState(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
