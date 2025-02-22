import 'package:flutter/material.dart';
import 'package:josresto/main.dart';
import 'package:provider/provider.dart';
import 'package:josresto/component/add_review_dialog.dart';
import 'package:josresto/data/model/customer_review.dart';
import 'package:josresto/provider/restaurant_add_review_provider.dart';
import 'package:josresto/provider/restaurant_detail_provider.dart';

class ReviewSection extends StatelessWidget {
  final List<CustomerReview> reviews;
  final String restaurantId;

  const ReviewSection(
      {super.key, required this.reviews, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Customer Reviews",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AddReviewDialog(
              onAddReview: (name, review) async {
                final reviewProvider =
                    context.read<RestaurantAddReviewProvider>();
                final detailProvider = context.read<RestaurantDetailProvider>();

                try {
                  await reviewProvider.addRestaurantReview(
                    id: restaurantId,
                    name: name,
                    review: review,
                  );

                  await detailProvider.fetchDetailRestaurant(restaurantId);

                  scaffoldMessengerKey.currentState?.showSnackBar(
                    const SnackBar(content: Text("Review added successfully!")),
                  );
                } catch (e) {
                  scaffoldMessengerKey.currentState?.showSnackBar(
                    SnackBar(content: Text("Failed to add review: $e")),
                  );
                }
              },
            ),
          ),
          icon: const Icon(Icons.add),
          label: const Text("Add Review"),
        ),
        const SizedBox(height: 16),
        if (reviews.isEmpty)
          const Center(
            child: Text(
              "No reviews yet. Be the first to leave a review!",
              style: TextStyle(color: Colors.grey),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            itemBuilder: (context, index) {
              final review = reviews[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      review.review,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      review.date,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}
