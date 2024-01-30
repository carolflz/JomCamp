import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/widget/display_row.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class DisplayWidget extends StatelessWidget {
  const DisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Cancel').snapshots(),
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
    String bookingId = item['Booking Id'];
    String id = item.id;
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
          // Add a container with padding that contains the card's title, text, and buttons
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Display the card's title using a font size of 24 and a dark grey color
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Booking')
                        .doc(bookingId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }

                      var output =
                          snapshot.data!.data() as Map<String, dynamic>;
                      String campsiteId = output["Campsite Id"];

                      return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("google_map_campsites")
                              .doc(campsiteId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            var output =
                                snapshot.data!.data() as Map<String, dynamic>;
                            String value = output["Name"] ?? "Unknown";

                            return Text(value,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.grey[800],
                                ));
                          });
                    }),
                const SizedBox(
                  height: 5,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Booking')
                        .doc(bookingId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      var output =
                          snapshot.data!.data() as Map<String, dynamic>;
                      String date = output["Date"];
                      String time = output["Time"];
                      String userid = output["User Id"];

                      return Column(
                        children: [
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(userid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                }
                                var output = snapshot.data!.data()
                                    as Map<String, dynamic>;
                                String user = output["Name"] ?? "Unknown Date";

                                return Row(
                                  children: [
                                    Text(
                                      "Book By ",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Text(
                                      user,
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                );
                              }),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              DisplayRow(title: "Date: ", description: date),
                              const SizedBox(
                                width: 15,
                              ),
                              DisplayRow(title: "Time: ", description: time),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              // Add a spacer to push the buttons to the right side of the card
                              const Spacer(),
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.transparent,
                                ),
                                child: const Text(
                                  "Approve",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                                onPressed: () {
                                  final snackBar = SnackBar(
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'Approved',
                                      message:
                                          'The Booking Cancelation Request is Approved',
                                      contentType: ContentType.success,
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);

                                  FirebaseFirestore.instance
                                      .collection('Booking')
                                      .doc(bookingId)
                                      .delete();

                                  FirebaseFirestore.instance
                                      .collection('Cancel')
                                      .doc(id)
                                      .delete();
                                },
                              ),
                              // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.transparent,
                                ),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                                onPressed: () {
                                  final snackBar = SnackBar(
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'Disapproved',
                                      message:
                                          'The Booking Cancelation Request is Canceled ',
                                      contentType: ContentType.failure,
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);

                                  FirebaseFirestore.instance
                                      .collection('Cancel')
                                      .doc(id)
                                      .delete();
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    })
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
