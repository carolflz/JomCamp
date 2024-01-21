// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/widget/display_row.dart';
import 'package:web_admin/widget/read_and_display.dart';

class DisplayWidget extends StatelessWidget {
  const DisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Booking').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        var items = snapshot.data!.docs;
        int counter = 1;
        return Column(
          children: [
            for (var item in items)
              Display(
                item: item,
                index: counter++,
              ),
          ],
        );
      },
    );
  }
}

class Display extends StatelessWidget {
  final DocumentSnapshot<Object?> item;
  // ignore: prefer_typing_uninitialized_variables
  final index;

  const Display({
    super.key,
    required this.item,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final String id = item.id;
    String time = item['Time'];
    String date = item['Date'];
    String campid = item['Campsite Id'];
    String userid = item['User Id'];

    return Card(
      // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      // Set the clip behavior of the card
      clipBehavior: Clip.antiAliasWithSaveLayer,
      // Define the child widgets of the card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
          Image.asset(
            'assets/Booking.png',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          // Add a container with padding that contains the card's title, text, and buttons
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Display the card's title using a font size of 24 and a dark grey color
                DisplayFirebase(
                  collection: "google_map_campsites",
                  id: campid,
                  title: "Campsite",
                  makeTitle: true,
                ),
                // Add a space between the title and the text
                Container(height: 10),
                // Display the card's text using a font size of 15 and a light grey color
                DisplayFirebase(
                  collection: "users",
                  id: userid,
                  title: "Booked by: ",
                  makeTitle: false,
                ),
                Container(height: 5),
                Row(
                  children: [
                    DisplayRow(
                      title: 'Date: ',
                      description: date,
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    DisplayRow(
                      title: 'Time: ',
                      description: time,
                    ),
                  ],
                )
              ],
            ),
          ),
          // Add a small space between the card and the next widget
          Container(height: 5),
        ],
      ),
    );
  }
}
