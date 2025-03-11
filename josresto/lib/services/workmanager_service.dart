// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:josresto/data/api/api_service.dart';
// import 'package:josresto/data/model/restaurant.dart';
// import 'package:josresto/data/model/restaurant_list_response.dart';
// import 'package:josresto/services/local_notification_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:workmanager/workmanager.dart';

// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     debugPrint("WorkManager task executed: $task");
//     try {
//       tz.initializeTimeZones();
//       final localNotificationService = LocalNotificationService();
//       await localNotificationService.init();
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       bool isReminderEnabled = prefs.getBool('daily_reminder') ?? true;

//       if (!isReminderEnabled) {
//         return Future.value(true);
//       }

//       final restaurant = await fetchRandomRestaurant();

//       if (restaurant != null) {
//         await localNotificationService.showNotification(
//             id: 100,
//             title: "Rekomendasi Restoran Hari Ini 🍽️",
//             body: "${restaurant.name}\n di ${restaurant.city}");
//       } else {
//         debugPrint("Gagal mengambil restoran");
//       }

//       // debugPrint("Notifikasi pukul 11:00 AM telah dijadwalkan ulang.");

//       return Future.value(true);
//     } catch (e) {
//       debugPrint("Error di callbackDispatcher: $e");
//       return Future.value(false);
//     }
//   });
// }

// Future<Restaurant?> fetchRandomRestaurant() async {
//   final apiService = ApiService();

//   try {
//     RestaurantListResponse restaurantListResponse =
//         await apiService.getRestaurantList();

//     List<Restaurant> restaurant = restaurantListResponse.restaurants;

//     if (restaurant.isNotEmpty) {
//       final random = Random();
//       return restaurant[random.nextInt(restaurant.length)];
//     }
//   } catch (e, stackTrace) {
//     debugPrint("Error fetching random restaurant: $e");
//     debugPrint("Stack trace: $stackTrace");
//   }

//   return null;
// }

// class WorkmanagerService {
//   Duration _calculateNextTriggerTime() {
//     final now = DateTime.now();
//     final next11AM = DateTime(now.year, now.month, now.day, 5, 30);

//     if (now.isAfter(next11AM)) {
//       return next11AM.add(Duration(days: 1)).difference(now);
//     } else {
//       return next11AM.difference(now);
//     }
//   }

//   Future<void> scheduleDailyReminder() async {
//     await Workmanager().cancelAll();

//     final delayDuration = _calculateNextTriggerTime();
//     debugPrint("Notifikasi pertama akan dikirim dalam $delayDuration");
//     final now = DateTime.now();
//     final nextTriggerTime = now.add(delayDuration);

//     await Workmanager().registerPeriodicTask(
//         "daily_task", "daily_notification_task",
//         initialDelay: delayDuration,
//         frequency: Duration(days: 1),
//         constraints: Constraints(networkType: NetworkType.connected),
//         existingWorkPolicy: ExistingWorkPolicy.replace);
//     debugPrint(
//         "Notifikasi selanjutnya dijadwalkan pada: ${nextTriggerTime.toLocal()}");
//   }

//   Future<void> cancelAllTask() async {
//     await Workmanager().cancelAll();
//   }
// }
