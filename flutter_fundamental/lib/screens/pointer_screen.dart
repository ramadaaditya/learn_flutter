import 'package:flutter/material.dart';
import 'package:flutterdayone/components/listener_example.dart';

class PointerScreen extends StatelessWidget {
  const PointerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: ListenerExample(),
      ),
    );
  }
}
