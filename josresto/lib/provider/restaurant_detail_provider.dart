import 'package:flutter/material.dart';
import 'package:josresto/data/api/api_service.dart';
import 'package:josresto/static/restaurant_detail_result_state.dart';
import 'package:josresto/utils/handler.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService _apiService;

  RestaurantDetailProvider(this._apiService);

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();
  RestaurantDetailResultState get resultState => _resultState;

  Future<void> fetchDetailRestaurant(String id) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();
      final result = await _apiService.getRestaurantDetail(id);
      _resultState = RestaurantDetailLoadedState(result.restaurant);
    } catch (e) {
      _resultState = RestaurantDetailErrorState(
          ErrorHandler.errorHandlerMessage(e.toString()));
    }
    notifyListeners();
  }
}
