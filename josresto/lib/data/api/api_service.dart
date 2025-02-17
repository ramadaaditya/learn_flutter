import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:josresto/data/model/restaurant_add_review_response.dart';
import 'package:josresto/data/model/restaurant_detail_response.dart';
import 'package:josresto/data/model/restaurant_list_response.dart';
import 'package:josresto/data/model/restaurant_search_response.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse is Map<String, dynamic>) {
        return RestaurantListResponse.fromJson(jsonResponse);
      } else {
        throw Exception("Invalid JSON format");
      }
    } else {
      throw Exception("Failed to load restaurant list: ${response.statusCode}");
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load restaurant detail");
    }
  }

  Future<RestaurantSearchResponse> getSearchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to search restaurants with query : $query");
    }
  }

  Future<RestaurantAddReviewResponse> addRestaurantReview({
    required String id,
    required String name,
    required String review,
  }) async {
    final url = Uri.parse("$_baseUrl/review");
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "id": id,
        "name": name,
        "review": review,
      }),
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse is Map<String, dynamic>) {
        return RestaurantAddReviewResponse.fromJson(jsonResponse);
      } else {
        throw Exception("Invalid JSON format");
      }
    } else {
      throw Exception("Failed to add review: ${response.statusCode}");
    }
  }
}
