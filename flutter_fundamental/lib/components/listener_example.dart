import 'package:flutter/material.dart';

class ListenerExample extends StatefulWidget {
  const ListenerExample({super.key});

  @override
  State<ListenerExample> createState() => ListenerExampleState();
}

class ListenerExampleState extends State<ListenerExample> {
  int _downCounter = 0;
  int _upCounter = 0;
  double x = 0.0;
  double y = 0.0;

  void _incrementDown(PointerEvent detail) {
    setState(() {
      _downCounter++;
      _updateLocation(detail);
    });
  }

  void _incrementUp(PointerEvent detail) {
    setState(() {
      _upCounter++;
      _updateLocation(detail);
    });
  }

  void _updateLocation(PointerEvent detail) {
    setState(() {
      x = detail.localPosition.dx;
      y = detail.localPosition.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.tight(const Size(300.0, 200.0)),
        child: Listener(
          onPointerDown: _incrementDown,
          onPointerUp: _incrementUp,
          onPointerMove: _updateLocation,
          child: ColoredBox(
            color: Colors.teal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                    "Kamu sudah menekan atau melepas tombol ini sebanyak:"),
                Text(
                  '$_downCounter presses\n$_upCounter presses',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  'The Cursor is here: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
