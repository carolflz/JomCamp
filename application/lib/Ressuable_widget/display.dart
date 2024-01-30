// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

// ignore: must_be_immutable
class DisplayWidget extends StatelessWidget {
  final String selectedPost;
  const DisplayWidget({super.key, required this.selectedPost});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Comments')
          .where("postId", isEqualTo: selectedPost)
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
    print(id);
    String comment = item['comment'];
    String user = item['userId'];
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
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(user)
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
                      String user = output["Name"] ?? "Unknown Date";

                      return Text(
                        user,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      );
                    }),
                ReadMoreText(
                  comment,
                  trimLines: 2,
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Container(height: 5),
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
