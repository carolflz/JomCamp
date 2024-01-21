// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:web_admin/widget/rental.dart';

class RentalScreen extends StatefulWidget {
  const RentalScreen({super.key});

  static const String routeName = '/Rental';

  @override
  State<RentalScreen> createState() => _RentalScreenState();
}

class _RentalScreenState extends State<RentalScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                Text('Rental Screen',
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
