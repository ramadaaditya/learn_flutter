import 'package:flutter/material.dart';

class CustomContainerWidget extends StatefulWidget {
  const CustomContainerWidget({super.key});

  @override
  State<CustomContainerWidget> createState() => _CustomContainerWidget();
}

class _CustomContainerWidget extends State<CustomContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/profile.png",
      fit: BoxFit.cover,
      height: 150,
      width: 150,
    );
  }
}
