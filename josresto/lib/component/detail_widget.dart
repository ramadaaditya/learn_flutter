import 'package:flutter/material.dart';
import 'package:josresto/component/menu_item.dart';
import 'package:josresto/component/review_section.dart';
import 'package:josresto/data/model/restaurant.dart';

class DetailRestaurantWidget extends StatelessWidget {
  final Restaurant restaurant;
  final Function(String name, String review) onAddReview;

  const DetailRestaurantWidget(
      {super.key, required this.restaurant, required this.onAddReview});

  void _showAddReviewDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController reviewController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Review"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Your Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: reviewController,
              decoration: const InputDecoration(
                labelText: "Your Review",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final review = reviewController.text.trim();

              if (name.isNotEmpty && review.isNotEmpty) {
                onAddReview(name, review);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please fill in both fields"),
                  ),
                );
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: restaurant.pictureId,
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox.square(dimension: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          restaurant.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            restaurant.rating.toString(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_city,
                        size: 18,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          restaurant.city,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        size: 18,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          restaurant.address,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Description
                  Text(
                    "Description",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    restaurant.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                        ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  MenuItem(
                      title: "Foods",
                      items: restaurant.menus.food
                          .map((item) => item.name)
                          .toList()),
                  const SizedBox(height: 16),
                  MenuItem(
                      title: "Drinks",
                      items: restaurant.menus.drinks
                          .map((item) => item.name)
                          .toList()),
                  const SizedBox(height: 16),
                  Text(
                    "Customer Reviews",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => _showAddReviewDialog(context),
                    icon: const Icon(Icons.add),
                    label: const Text("Add Review"),
                  ),
                  const SizedBox(height: 16),
                  ReviewSection(reviews: restaurant.customerReviews),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
