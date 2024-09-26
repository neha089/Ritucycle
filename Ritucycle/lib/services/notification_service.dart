// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/material.dart';
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
// void initializeNotifications() {
//   const AndroidInitializationSettings initializationSettingsAndroid =
//   AndroidInitializationSettings('app_icon');
//
//   final InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//   );
//
//   flutterLocalNotificationsPlugin.initialize(initializationSettings);
// }
//
// Future<void> showDailyQuoteNotification() async {
//   final now = DateTime.now();
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//   AndroidNotificationDetails('daily_quote_channel', 'Daily Quote',
//       channelDescription: 'Daily motivational quotes',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker');
//   const NotificationDetails platformChannelSpecifics = NotificationDetails(
//     android: androidPlatformChannelSpecifics,
//   );
//
//   await flutterLocalNotificationsPlugin.showDailyAtTime(
//     0,
//     'Your Daily Quote',
//     'Here is your motivational quote for today.',
//     Time(now.hour, now.minute, now.second),
//     platformChannelSpecifics,
//   );
// }
