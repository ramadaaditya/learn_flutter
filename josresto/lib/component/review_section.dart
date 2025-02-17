import 'package:flutter/material.dart';
import 'package:josresto/data/model/customer_review.dart';

class ReviewSection extends StatelessWidget {
  final List<CustomerReview> reviews;

  const ReviewSection({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
