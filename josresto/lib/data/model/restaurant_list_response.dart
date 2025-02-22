import 'package:josresto/data/model/restaurant.dart';

class RestaurantListResponse {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantListResponse(
      error: json["error"] ?? true,
      message: json["message"] ?? "Unknown error",
      count: json["count"] ?? 0,
      restaurants: (json["restaurants"] as List<dynamic>?)
              ?.map((x) => Restaurant.fromJson(x as Map<String, dynamic>))
              .toList() ??
          <Restaurant>[],
    );
  }
}
