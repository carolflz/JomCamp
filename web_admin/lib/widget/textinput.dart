// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class TextInput extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  const TextInput({super.key, required this.title, required this.controller});

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
          prefixIcon: Icon(LineAwesomeIcons.campground)),
      controller: controller,
    );
  }
}
