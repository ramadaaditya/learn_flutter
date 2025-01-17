import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Navigation & Routing"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
                child: const Text("Go to Second Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/second-with-data',
                      arguments: "Hello from first Screen");
                },
                child: const Text("Navigation with Data")),
            ElevatedButton(
                onPressed: () async {
                  final result =
                      await Navigator.pushNamed(context, '/return-data');

                  if (!context.mounted || result is! String) return;
                  SnackBar snackBar = SnackBar(content: Text(result));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Text("Return Data from Another Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/replacement');
                },
                child: const Text("Replace Screen")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/pointer');
                },
                child: const Text('Interaction Model Widget')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/gesture-detector');
                },
                child: const Text("Gesture Detector"))
          ],
        ),
      ),
    );
  }
}
