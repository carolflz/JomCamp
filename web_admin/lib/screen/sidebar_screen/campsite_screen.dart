import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class CampsiteScreen extends StatelessWidget {
  // ignore: unnecessary_string_escapes
  static const String routeName = '\Campsite';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: const Text(
          'Campsite Screen',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 36,
          ),
        ),
      ),
    );
  }
}
