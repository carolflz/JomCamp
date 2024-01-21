// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:web_admin/widget/booking.dart';

class ReservationScreen extends StatelessWidget {
  // ignore: unnecessary_string_escapes
  static const String routeName = '/Reservation';
  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                Text('Booking Screen',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                    )),
                SizedBox(
                  width: 850,
                ),
              ],
            ),
            DisplayWidget(),
          ],
        ));
  }
}
