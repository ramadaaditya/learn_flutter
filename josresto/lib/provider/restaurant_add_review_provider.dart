import 'package:flutter/material.dart';
import 'package:josresto/data/api/api_service.dart';
import 'package:josresto/data/model/customer_review.dart';
import 'package:josresto/static/restaurant_add_review_result_state.dart';

class RestaurantAddReviewProvider extends ChangeNotifier {
  final ApiService _apiService;

  RestaurantAddReviewProvider(this._apiService);

  RestaurantAddReviewResultState _resultState = RestaurantAddReviewNoneState();
  RestaurantAddReviewResultState get resultState => _resultState;

  List<CustomerReview> _customerReviews = [];
  List<CustomerReview> get customerReviews => _customerReviews;

  Future<void> addRestaurantReview({
    required String id,
    required String name,
    required String review,
  }) async {
    try {
      _resultState = RestaurantAddReviewLoadingState();
      notifyListeners();
      final result = await _apiService.addRestaurantReview(
          id: id, name: name, review: review);

      if (result.error) {
        _resultState = RestaurantAddReviewErrorState(result.message);
      } else {
        _customerReviews = result.customerReview;
        _resultState = RestaurantAddReviewSuccessState(result.message);
      }
    } catch (e) {
      _resultState = RestaurantAddReviewErrorState(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
