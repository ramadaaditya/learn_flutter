import 'package:flutter/material.dart';
import 'package:josresto/component/favorite_icon_widget.dart';
import 'package:josresto/data/model/restaurant.dart';
import 'package:josresto/provider/database_provider.dart';
import 'package:provider/provider.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final Function() onTap;
  final double height;
  final double width;

  const RestaurantCard(
      {super.key,
      required this.onTap,
      required this.restaurant,
      this.height = 80,
      this.width = 120});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: height,
                    minHeight: height,
                    maxWidth: width,
                    minWidth: width,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Hero(
                      tag: restaurant.pictureId,
                      child: Image.network(
                        'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: height,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.broken_image,
                                size: 50, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox.square(dimension: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              restaurant.name,
                              style: Theme.of(context).textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          FavoriteIconWidget(restaurant: restaurant)
                        ],
                      ),
                      const SizedBox.square(dimension: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_city,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox.square(dimension: 4),
                          Expanded(
                            child: Text(
                              restaurant.city,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox.square(dimension: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox.square(dimension: 4),
                          Text(
                            restaurant.rating.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
