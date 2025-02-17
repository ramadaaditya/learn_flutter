import 'package:flutter/material.dart';
import 'package:josresto/data/api/api_service.dart';
import 'package:josresto/static/restaurant_search_result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService _apiService;

  RestaurantSearchProvider(this._apiService);

  RestaurantSearchResultState _resultState = RestaurantSearchNoneState();
  RestaurantSearchResultState get resultState => _resultState;

  void resetSearchState() {
    _resultState = RestaurantSearchNoneState();
    notifyListeners();
  }

  Future<void> fetchRestaurantData(String query) async {
    try {
      _resultState = RestaurantSearchLoadingState();
      notifyListeners();
      final result = await _apiService.getSearchRestaurant(query);
      if (result.error) {
        _resultState = RestaurantSearchErrorState("Error fetching data");
      } else if (result.restaurants.isEmpty) {
        _resultState = RestaurantSearchEmptyState();
      } else {
        _resultState = RestaurantSearchLoadedState(result.restaurants);
      }
    } on Exception catch (e) {
      _resultState = RestaurantSearchErrorState(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
