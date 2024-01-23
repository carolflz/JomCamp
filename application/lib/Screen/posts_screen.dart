import 'package:flutter/material.dart';
import 'package:application/Models/post_Model.dart';

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
        title: Text('Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '${selectedPost.userName}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Image.network(selectedPost.imagePath), // Display post image
            SizedBox(height: 10),
            Text(
              selectedPost.imageTitle,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              formattedDate,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Likes: ${selectedPost.likes}',
              style: TextStyle(fontSize: 16),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
