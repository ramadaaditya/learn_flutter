import 'package:flutter/material.dart';

import 'my_stateful_widget_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
        onDetach: () => debugPrint("app-detached"),
        onInactive: () => debugPrint("app-inactive"),
        onPause: () => debugPrint("app-paused"),
        onResume: () => debugPrint("app-resumed"),
        onRestart: () => debugPrint("app-restarted"),
        onShow: () => debugPrint("app-showed"),
        onHide: () => debugPrint("app-hide"));
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Lifecycle App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyStatefulWidget(),
    );
  }
}
