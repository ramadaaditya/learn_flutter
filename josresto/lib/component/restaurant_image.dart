import 'package:flutter/material.dart';

class RestaurantImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  const RestaurantImage({super.key, required this.imageUrl, this.height = 250});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imageUrl,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          'https://restaurant-api.dicoding.dev/images/large/$imageUrl',
          width: double.infinity,
          height: height,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: height,
              width: double.infinity,
              color: Colors.grey[300], // Placeholder saat loading
              child: const Center(child: CircularProgressIndicator()),
            );
          },
          errorBuilder: (context, error, stackTrace) => Container(
            height: height,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Center(
              child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
