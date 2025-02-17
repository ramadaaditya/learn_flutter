import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final List<String> items;
  const MenuItem({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
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
