import 'package:application/Ressuable_widget/display.dart';
import 'package:flutter/material.dart';
import 'package:application/Models/post_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rich_readmore/rich_readmore.dart';

class PostsScreen extends StatelessWidget {
  final int postIndex;
  final List<Post> posts; // Add a list of posts as a parameter

  PostsScreen({Key? key, required this.postIndex, required this.posts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Post selectedPost =
        posts[postIndex]; // Retrieve the selected post using the index

    // Convert 'Timestamp' to 'String'
    String formattedDate = selectedPost.postDate.toDate().toString();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 30, 32, 30),
              child: Icon(Icons.person, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(selectedPost.userName)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    var output = snapshot.data!.data() as Map<String, dynamic>;

                    String name = output["Name"] ?? "Unknown";
                    return Text(
                      name,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(255, 30, 32, 30),
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                selectedPost.imageTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                      selectedPost.imagePath), // Display post image
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Post")
                        .doc(selectedPost.documentId)
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

                      String description = output["description"] ?? "Unknown";
                      return Column(
                        children: [
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(selectedPost.userName)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                }
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                }
                                var output = snapshot.data!.data()
                                    as Map<String, dynamic>;

                                String name = output["Name"] ?? "Unknown";
                                TextSpan text = TextSpan(children: [
                                  TextSpan(
                                      text: "$name ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  TextSpan(
                                      text: description,
                                      style: TextStyle(color: Colors.black)),
                                ]);

                                return RichReadMoreText(
                                  text,
                                  settings: LineModeSettings(
                                    trimLines: 3,
                                    trimCollapsedText: 'Show More',
                                    trimExpandedText: ' Show Less ',
                                    textAlign: TextAlign.justify,
                                    onPressReadMore: () {
                                      /// specific method to be called on press to show more
                                    },
                                    onPressReadLess: () {
                                      /// specific method to be called on press to show less
                                    },
                                    lessStyle: TextStyle(color: Colors.blue),
                                    moreStyle: TextStyle(color: Colors.blue),
                                  ),
                                );
                              }),
                        ],
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  formattedDate,
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Likes  ${selectedPost.likes}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Comments  ',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              DisplayWidget(selectedPost: selectedPost.documentId)

              // Add more details as needed
            ],
          ),
        ),
      ),
    );
  }
}
