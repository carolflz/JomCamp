import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationController {
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreateMethod(
      ReceivedNotification recerivedNotification) async {
    debugPrint('onNotificationCreateMethod');
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayMethod(
      ReceivedNotification recerivedNotification) async {
    debugPrint('onNotificationDisplayMethod');
  }

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction recerivedAction) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction recerivedAction) async {
    debugPrint('onActionReceivedMethod');
  }
}
