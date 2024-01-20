// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:web_admin/screen/update_screen.dart';

class DisplayWidget extends StatelessWidget {
  const DisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('google_map_campsites')
          .snapshots(),
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
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          description,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[700],
          ),
        ),
      ],
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
    String title = item['Name'];
    String address = item['Address'];
    String level = item['Level'];
    String category = item['Category'];
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
            'assets/Campsite.png',
            height: 160,
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
                Text(
                  '$index) $title',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey[800],
                  ),
                ),
                // Add a space between the title and the text
                Container(height: 10),
                // Display the card's text using a font size of 15 and a light grey color
                DisplayRow(
                  title: 'Address: ',
                  description: address,
                ),
                Container(height: 5),
                Row(
                  children: [
                    DisplayRow(
                      title: 'Level: ',
                      description: level,
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    DisplayRow(
                      title: 'Category: ',
                      description: category,
                    ),
                  ],
                ),
                // Add a row with two buttons spaced apart and aligned to the right side of the card
                Row(
                  children: <Widget>[
                    // Add a spacer to push the buttons to the right side of the card
                    const Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.transparent,
                      ),
                      child: const Text(
                        "EDIT",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateScreen(
                                    objId: id,
                                  )),
                        );
                      },
                    ),
                    // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.transparent,
                      ),
                      child: const Text(
                        "DELETE",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      onPressed: () {
                        Widget comfirmBut = TextButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('google_map_campsites')
                                  .doc(id)
                                  .delete();
                              Navigator.of(context).pop();
                            },
                            child: const Text('Comfirm'));

                        Widget closeBut = TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'));

                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.confirm,
                          title: 'Delete Comfirmation',
                          text:
                              'This action cannot be undone. Please confirm if you want to proceed with deleting this data.',
                          confirmBtnText: 'Yes',
                          confirmBtnColor: Colors.green,
                          onConfirmBtnTap: () {
                            FirebaseFirestore.instance
                                .collection('google_map_campsites')
                                .doc(id)
                                .delete();
                            Navigator.of(context).pop();
                          },
                          cancelBtnText: 'No',
                        );

                        // showDialog(
                        //     context: context,
                        //     builder: (context) => AlertDialog(
                        //           actions: [closeBut, comfirmBut],
                        //           title: const Text('Delete Comfirmation'),
                        //           contentPadding: const EdgeInsets.all(20),
                        //           content: const Text(
                        //               'Are you sure you want to delete this item?\n\nThis action cannot be undone. Please confirm if you want to proceed with deleting this data.'),
                        //         ));
                      },
                    ),
                  ],
                ),
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
