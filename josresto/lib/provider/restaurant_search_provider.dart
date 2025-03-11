import 'package:flutter/material.dart';
import 'package:josresto/data/api/api_service.dart';
import 'package:josresto/static/restaurant_search_result_state.dart';
import 'package:josresto/utils/handler.dart';

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
      _resultState = RestaurantSearchLoadedState(result.restaurants);
    } catch (e) {
      _resultState = RestaurantSearchErrorState(
          ErrorHandler.errorHandlerMessage(e.toString()));
    }
    notifyListeners();
  }
}
