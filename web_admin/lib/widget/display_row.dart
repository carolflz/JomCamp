import 'package:flutter/material.dart';

class DisplayRow extends StatelessWidget {
  final String title, description;
  const DisplayRow({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey[700],
          ),
        ),
        Text(
          description,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
