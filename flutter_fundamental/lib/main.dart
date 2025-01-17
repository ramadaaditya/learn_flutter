import 'package:flutter/material.dart';
import 'package:flutterdayone/screens/another_screen.dart';
import 'package:flutterdayone/screens/first_screen.dart';
import 'package:flutterdayone/screens/gesture_screen.dart';
import 'package:flutterdayone/screens/pointer_screen.dart';
import 'package:flutterdayone/screens/replacement_screen.dart';
import 'package:flutterdayone/screens/return_data_screen.dart';
import 'package:flutterdayone/screens/second_screen.dart';
import 'package:flutterdayone/screens/second_screen_with_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstScreen(),
        '/second': (context) => const SecondScreen(),
        '/second-with-data': (context) => SecondScreenWithData(
              data: ModalRoute.of(context)?.settings.arguments as String,
            ),
        '/return-data': (context) => const ReturnDataScreen(),
        '/replacement': (context) => const ReplacementScreen(),
        '/another': (context) => const AnotherScreen(),
        '/pointer': (context) => const PointerScreen(),
        '/gesture-detector': (context) => const GestureScreen(),
      },
    );
  }
}
