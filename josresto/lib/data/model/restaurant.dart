import 'package:josresto/data/model/category.dart';
import 'package:josresto/data/model/customer_review.dart';
import 'package:josresto/data/model/menu.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String address;
  final List<Category> categories;
  final Menus menus;
  final double rating;
  final List<CustomerReview> customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.address,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      pictureId: json["pictureId"] ?? "",
      city: json["city"] ?? "",
      address: json["address"] ?? "",
      rating: (json["rating"] as num?)?.toDouble() ?? 0.0,
      categories: (json["categories"] as List<dynamic>?)
              ?.map((category) => Category.fromJson(category))
              .toList() ??
          [],
      menus: json["menus"] != null
          ? Menus.fromJson(json["menus"])
          : Menus(food: [], drinks: []),
      customerReviews: (json["customerReviews"] as List<dynamic>?)
              ?.map((review) => CustomerReview.fromJson(review))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "pictureId": pictureId,
      "city": city,
      "address": address,
      "rating": rating,
      "categories": categories.isNotEmpty
          ? categories.map((category) => category.toJson()).toList()
          : [],
      "menus": menus.toJson(),
      "customerReviews": customerReviews.isNotEmpty
          ? customerReviews.map((review) => review.toJson()).toList()
          : [],
    };
  }
}
