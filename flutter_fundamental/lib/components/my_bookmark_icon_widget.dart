import 'package:flutter/material.dart';

class MyBookmarkIconWidget extends StatefulWidget {
  const MyBookmarkIconWidget({super.key});

  @override
  State<MyBookmarkIconWidget> createState() => MyBookmarkIconWidgetState();
}

class MyBookmarkIconWidgetState extends State<MyBookmarkIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.bookmark_border,
      color: Colors.grey,
      size: 60,
    );
  }
}
