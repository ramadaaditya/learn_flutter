import 'package:flutter/material.dart';
import 'package:josresto/data/model/restaurant.dart';
import 'package:josresto/provider/database_provider.dart';
import 'package:provider/provider.dart';

class FavoriteIconWidget extends StatelessWidget {
  final Restaurant restaurant;

  const FavoriteIconWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        final isFavorite =
            provider.restaurantList.any((item) => item.id == restaurant.id);

        return IconButton(
          onPressed: () async {
            await provider.toggleFavorite(restaurant);
          },
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
        );
      },
    );
  }
}
