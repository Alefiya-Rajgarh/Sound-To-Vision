import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:torch_light/torch_light.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SoundAction {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initializeNotifications() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings settings =
    InitializationSettings(android: androidSettings);
    await _notificationsPlugin.initialize(settings);
  }

  static Future<void> triggerAction(String label) async {
    switch (label) {
      case "animal_sound":
        Vibrate.feedback(FeedbackType.medium);
        break;

      case "doorbell":
        await TorchLight.enableTorch();
        await Future.delayed(Duration(milliseconds: 500));
        await TorchLight.disableTorch();
        Vibrate.feedback(FeedbackType.medium);
        break;

      case "nature":
      // Show weather animation UI (handle this in your screen)
        break;

      case "siren":
        Vibrate.feedback(FeedbackType.heavy);
        break;

      case "speech":
        Vibrate.feedback(FeedbackType.light);
        break;

      case "vehicle_horn":
        _showNotification();
        Vibrate.feedback(FeedbackType.medium);
        break;
    }
  }

  static Future<void> _showNotification() async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails("channel_id", "Channel Name",
        importance: Importance.high, priority: Priority.high);
    const NotificationDetails details = NotificationDetails(android: androidDetails);
    await _notificationsPlugin.show(
      0,
      "Alert",
      "There is a vehicle horn nearby.",
      details,
    );
  }
}