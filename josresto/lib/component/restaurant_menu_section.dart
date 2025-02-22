import 'package:flutter/material.dart';

class RestaurantMenuSection extends StatelessWidget {
  final List<String> foodItems;
  final List<String> drinkItems;

  const RestaurantMenuSection(
      {super.key, required this.foodItems, required this.drinkItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMenuCategory("Foods", foodItems),
        const SizedBox(height: 16),
        _buildMenuCategory("Drinks", drinkItems)
      ],
    );
  }

  Widget _buildMenuCategory(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: items
                .map((item) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Chip(
                        label: Text(item),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
