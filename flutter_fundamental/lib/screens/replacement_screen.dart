import 'package:flutter/material.dart';

class ReplacementScreen extends StatelessWidget {
  const ReplacementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/another');
            },
            child: const Text("Open Another Screen")),
      ),
    );
  }
}
