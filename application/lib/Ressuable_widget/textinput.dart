// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String title;
  final IconData icon;
  final TextEditingController controller;
  const TextInput(
      {super.key,
      required this.title,
      required this.controller,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          label: Text(title),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
          floatingLabelStyle: TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(width: 2)),
          prefixIcon: Icon(icon)),
      controller: controller,
    );
  }
}
