import 'package:flutter/material.dart';
import 'package:flutterdayone/components/custom_container_widget.dart';
import 'package:flutterdayone/components/my_bookmark_icon_widget.dart';

class GestureScreen extends StatefulWidget {
  const GestureScreen({super.key});

  @override
  State<GestureScreen> createState() => GestureScreenState();
}

class GestureScreenState extends State<GestureScreen> {
  bool _lockOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: FractionalOffset.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                _lockOpen ? Icons.lock_open_outlined : Icons.lock_outlined,
                color: Colors.black,
                size: 60,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _lockOpen = !_lockOpen;
                });
              },
              child: Container(
                color: Colors.orange.shade600,
                padding: const EdgeInsets.all(8),
                child: Text(_lockOpen ? 'Close The Lock' : 'Open The Lock'),
              ),
            ),
            Container(height: 32),
            CustomContainerWidget(),
            Container(height: 32),
            MyBookmarkIconWidget()
          ],
        ),
      ),
    );
  }
}
