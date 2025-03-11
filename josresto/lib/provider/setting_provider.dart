import 'package:flutter/material.dart';
import 'package:josresto/services/local_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _isDailyReminderActive = false;

  final LocalNotificationService _localNotificationService =
      LocalNotificationService();

  ThemeMode get themeMode => _themeMode;
  bool get isDailyReminderActive => _isDailyReminderActive;

  SettingProvider() {
    _loadSettings();
  }
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = (prefs.getBool('isDarkMode') ?? false)
        ? ThemeMode.dark
        : ThemeMode.light;
    _isDailyReminderActive = prefs.getBool('daily_reminder') ?? false;

    notifyListeners();

    if (_isDailyReminderActive) {
      await _localNotificationService.scheduleDailyElevenAMNotification(
          id: 101);
    }
  }

  Future<void> toggleTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);

    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> toggleDailyReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('daily_reminder', value);

    _isDailyReminderActive = value;
    notifyListeners();

    if (value) {
      await _localNotificationService.scheduleDailyElevenAMNotification(
          id: 101);
    } else {
      await _localNotificationService.cancelAllNotifications();
    }
  }
}
