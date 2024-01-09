import 'package:flutter/material.dart';

class ReservationScreen extends StatelessWidget {
  // ignore: unnecessary_string_escapes
  static const String routeName = '\Reservation';

  Widget _rowHeader(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade700),
            color: Colors.yellow.shade700),
        child: Center(
          child: Text(text,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
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
          Row(
            children: [
              _rowHeader('Id', 1),
              _rowHeader('Rental Info', 2),
              _rowHeader('Username', 3),
              _rowHeader('Rental Date', 4),
              _rowHeader('Return Date', 5),
              _rowHeader('Approval', 6),
            ],
          )
        ],
      ),
    );
  }
}
