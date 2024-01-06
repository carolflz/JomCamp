import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NavigateScreen extends StatelessWidget {
  const NavigateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AwesomeNotifications().createNotification(
              content: NotificationContent(
                  id: 1,
                  channelKey: "basic_channel",
                  title: "Campsite Alert",
                  body:
                      "Severe weather conditions expected in your area. Stay informed and take precautions. Check local forecasts for updates. Your safety is our priority."));
        },
        child: Icon(
          Icons.notification_add,
        ),
      ),
    );
  }
}
