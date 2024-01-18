import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class DashboardScreen extends StatelessWidget {
  // ignore: unnecessary_string_escapes
  static const String routeName = '/Dashboard';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: const Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 36,
          ),
        ),
      ),
    );
  }
}
