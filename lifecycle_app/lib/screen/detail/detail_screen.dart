import 'package:flutter/material.dart';
import 'package:lifecycle_app/model/tourism.dart';

class DetailScreen extends StatelessWidget {
  final Tourism tourism;
  const DetailScreen({super.key, required this.tourism});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: const Text("Toursim Detail"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
