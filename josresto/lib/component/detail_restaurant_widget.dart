import 'package:flutter/material.dart';
import 'package:josresto/component/restaurant_image.dart';
import 'package:josresto/component/restaurant_info.dart';
import 'package:josresto/component/restaurant_menu_section.dart';
import 'package:josresto/component/review_section.dart';
import 'package:josresto/data/model/restaurant.dart';

class DetailRestaurantWidget extends StatelessWidget {
  final Restaurant restaurant;

  const DetailRestaurantWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RestaurantImage(imageUrl: restaurant.pictureId),
          const SizedBox(height: 16),
          RestaurantInfo(restaurant: restaurant),
          const SizedBox(height: 16),
          RestaurantMenuSection(
              foodItems:
                  restaurant.menus.food.map((item) => item.name).toList(),
              drinkItems:
                  restaurant.menus.drinks.map((item) => item.name).toList()),
          const SizedBox(height: 16),
          ReviewSection(
              reviews: restaurant.customerReviews, restaurantId: restaurant.id),
        ],
      ),
    ));
  }
}
