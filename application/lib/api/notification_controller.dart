import 'package:application/Ressuable_widget/create_id.dart';
import 'package:application/main.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

Future<void> createCampsiteAlertNotification() async {
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: creteUniqueId(),
          channelKey: "basic_channel",
          title: "Campsite Alert",
          body:
              "Severe weather conditions expected in your area. Stay informed and take precautions. Check local forecasts for updates. Your safety is our priority."));
}

class NotificationController {
  static BuildContext? appContext;

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
      ReceivedAction receivedAction) async {
    MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/notification-page',
        (route) =>
            (route.settings.name != '/notification-page') || route.isFirst,
        arguments: receivedAction);
    debugPrint('onActionReceivedMethod');
  }
}
