import 'package:flutter/material.dart';
import 'package:flutterdayone/model/tourism.dart';
import 'package:flutterdayone/screen/folder/tourism_card_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Tourism List"),
        ),
        body: ListView.builder(
          itemCount: tourismList.length,
          itemBuilder: (context, index) {
            final tourism = tourismList[index];

            return TourismCard(tourism: tourism);
          },
        ),
      ),
    );
  }
}
