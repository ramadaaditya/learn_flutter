import 'package:flutter/material.dart';

class AddReviewDialog extends StatelessWidget {
  final Function(String, String) onAddReview;
  const AddReviewDialog({super.key, required this.onAddReview});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final reviewController = TextEditingController();

    return AlertDialog(
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
    );
  }
}
