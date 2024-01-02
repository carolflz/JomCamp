import 'package:flutter/material.dart';

class ReservationScreen extends StatelessWidget {
  // ignore: unnecessary_string_escapes
  static const String routeName = '\Reservation';

  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: const Text(
          'Reservation Screen',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 36,
          ),
        ),
      ),
    );
  }
}
