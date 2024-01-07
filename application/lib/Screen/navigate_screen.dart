import 'package:application/api/notification_controller.dart';
import 'package:flutter/material.dart';

class NavigateScreen extends StatelessWidget {
  const NavigateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: createCampsiteAlertNotification,
        child: Icon(
          Icons.notification_add,
        ),
      ),
    );
  }
}
