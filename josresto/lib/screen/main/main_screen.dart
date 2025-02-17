import 'package:flutter/material.dart';
import 'package:josresto/provider/nav_provider.dart';
import 'package:josresto/screen/dashboard/dashboard_screen.dart';
import 'package:josresto/screen/setting/setting_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JosResto"),
        centerTitle: true,
      ),
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            0 => const DashboardScreen(),
            _ => const SettingScreen()
          };
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
        onTap: (index) {
          context.read<IndexNavProvider>().setIndexBottomNavBar = index;
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home", tooltip: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Setting", tooltip: "Setting")
        ],
      ),
    );
  }
}
