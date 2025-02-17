import 'package:josresto/data/model/customer_review.dart';

class RestaurantAddReviewResponse {
  final bool error;
  final String message;
  final List<CustomerReview> customerReview;

  RestaurantAddReviewResponse(
      {required this.error,
      required this.message,
      required this.customerReview});

  factory RestaurantAddReviewResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantAddReviewResponse(
      error: json["error"],
      message: json["message"],
      customerReview: (json["customerReviews"] as List<dynamic>?)
              ?.map((x) => CustomerReview.fromJson(x as Map<String, dynamic>))
              .toList() ??
          <CustomerReview>[],
    );
  }
}
