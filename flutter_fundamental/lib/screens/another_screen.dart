import 'package:flutter/material.dart';

class AnotherScreen extends StatelessWidget {
  const AnotherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text("Back to First Screen"),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Back"))
      ],
    )));
  }
}
