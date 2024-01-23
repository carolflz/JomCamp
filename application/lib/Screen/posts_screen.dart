import 'package:flutter/material.dart';
import 'package:application/Models/post_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        title: Text(
          'Post',
          style: TextStyle(
            fontSize: 25.0,
            letterSpacing: 2.0,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
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
                          var output =
                              snapshot.data!.data() as Map<String, dynamic>;

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
              SizedBox(height: 10),
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
                      return Text(
                        description,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Color.fromARGB(255, 30, 32, 30),
                          fontSize: 15,
                        ),
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
                      'Comments  0',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),

              // Add more details as needed
            ],
          ),
        ),
      ),
    );
  }
}
