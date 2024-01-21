// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayFirebase extends StatelessWidget {
  final String collection, id, title;
  final double font_Size = 24.0;
  final bool makeTitle;
  const DisplayFirebase(
      {super.key,
      required this.collection,
      required this.id,
      required this.title,
      required this.makeTitle});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(collection)
            .doc(id)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          var output = snapshot.data!.data() as Map<String, dynamic>;
          String value = output["Name"] ?? "Unknown";
          if (makeTitle) {
            return Text('$title: $value',
                style: TextStyle(
                  fontSize: font_Size,
                  color: Colors.grey[800],
                ));
          } else {
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
                  value,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold),
                ),
              ],
            );
          }
        });
  }
}
