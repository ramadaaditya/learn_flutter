import 'package:flutter/material.dart';
import 'package:josresto/provider/setting_provider.dart';
import 'package:josresto/services/local_notification_service.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingProvider>(context);
    final isDarkMode = settingProvider.themeMode == ThemeMode.dark;
    final isDailyReminderActive = settingProvider.isDailyReminderActive;
    final localNotificationService = LocalNotificationService();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text("Dark Mode"),
              value: isDarkMode,
              onChanged: (value) {
                settingProvider.toggleTheme(value);
              },
              secondary: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            ),
            SwitchListTile(
              title: const Text("Daily Reminder Lunch"),
              value: isDailyReminderActive,
              onChanged: (value) async {
                await localNotificationService.requestNotificationPermission();
                settingProvider.toggleDailyReminder(value);
              },
              secondary: Icon(isDailyReminderActive
                  ? Icons.notifications_active
                  : Icons.notifications_off),
            ),
          ],
        ),
      ),
    );
  }
}
