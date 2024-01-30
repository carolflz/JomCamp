import 'package:application/Models/constant.dart';
import 'package:flutter/material.dart';
import 'package:application/Ressuable_widget/post_widget.dart';
import 'package:application/Screen/posts_screen.dart';
import 'package:application/Screen/profile_screen.dart';
import 'package:application/Models/post_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComunityLocalScreen extends StatefulWidget {
  @override
  _ComunityLocalScreenState createState() => _ComunityLocalScreenState();
}

class _ComunityLocalScreenState extends State<ComunityLocalScreen> {
  // Updated list to fetch data from Firestore
  List<Post> posts = [];

  // Fetch posts from Firestore using a Stream
  void _fetchPosts() {
    FirebaseFirestore.instance
        .collection('Post')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      setState(() {
        posts = querySnapshot.docs.map((doc) {
          // Map Firestore fields to your Post model
          return Post(
            userName: doc['userId'],
            postDate: doc['postDate'],
            likes: doc['likes'],
            isLikedByUser: doc['isLikedByUser'],
            isFollowing: doc['isFollowing'],
            imagePath: doc['imagePath'],
            // ratings: doc['ratings'],
            imageTitle: doc['imageTitle'],
            documentId: doc.id, // Store the document ID
          );
        }).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Fetch posts when the screen is initialized
    _fetchPosts();
  }

  void _likePost(Post post) {
    setState(() {
      // Toggle the local like status
      _toggleLike(post);

      // Show a SnackBar based on like status
      if (post.isLikedByUser) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Liked Post')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unliked Post')),
        );
      }
    });
  }

  void _toggleLike(Post post) {
    if (post.isLikedByUser) {
      // User has already liked the post, so unlike it
      post.isLikedByUser = false;
      post.likes--;

      // Update Firestore document
      final postRef =
          FirebaseFirestore.instance.collection('Post').doc(post.documentId);

      postRef.update({
        'isLikedByUser': false,
        'likes': FieldValue.increment(-1), // Decrement likes by 1
      });
    } else {
      // User hasn't liked the post, so like it
      post.isLikedByUser = true;
      post.likes++;

      // Update Firestore document
      final postRef =
          FirebaseFirestore.instance.collection('Post').doc(post.documentId);

      postRef.update({
        'isLikedByUser': true,
        'likes': FieldValue.increment(1), // Increment likes by 1
      });
    }
  }

  void _commentPost(BuildContext context, int index, String postId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _commentController = TextEditingController();
        return AlertDialog(
          title: Text("Comment on Post "),
          content: TextField(
            controller: _commentController,
            decoration: InputDecoration(hintText: "Enter your comment here"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Comment'),
              onPressed: () async {
                // Check if the comment is not empty
                if (_commentController.text.trim().isNotEmpty) {
                  final comment =
                      FirebaseFirestore.instance.collection('Comments').doc();

                  // Create a map of comment data
                  final json = {
                    "comment": _commentController.text.trim(),
                    "postId": postId,
                    "userId": userId,
                  };

                  try {
                    await comment.set(json);
                    // Show a snackbar with a success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Commented on Post')),
                    );
                  } catch (e) {
                    // If there's an error, show a snackbar with the error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error commenting: $e')),
                    );
                  }
                } else {
                  // If the comment is empty, show a snackbar with a message to enter a comment
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a comment')),
                  );
                }

                // Clear the text field and close the dialog
                _commentController.clear();
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _handleFollowPressed(int index) {
    setState(() {
      // Toggle the isFollowing status locally
      posts[index].isFollowing = !posts[index].isFollowing;

      // Get the reference to the specific post document in Firestore
      DocumentReference postRef = FirebaseFirestore.instance
          .collection('Post')
          .doc(posts[index].documentId);

      // Update the 'isFollowing' field in Firestore
      postRef.update({'isFollowing': posts[index].isFollowing});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 5),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PostsScreen(postIndex: index, posts: posts),
                      ),
                    );
                  },
                  child: PostWidget(
                    onUsernameTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileScreen(userID: posts[index].userName)),
                      );
                    },
                    id: posts[index].documentId,
                    userName: posts[index].userName,
                    postDate: posts[index].formattedDate,
                    postIndex: index,
                    likes: posts[index].likes,
                    isLikedByUser: posts[index].isLikedByUser,
                    imagePath: posts[index].imagePath,
                    ratings: posts[index].ratings,
                    imageTitle: posts[index].imageTitle,
                    onLikePressed: (index) => _likePost(posts[index]),
                    onCommentPressed: (index) => _commentPost(
                      context,
                      index,
                      posts[index].documentId,
                    ),
                    isFollowing: posts[index].isFollowing,
                    onFollowPressed: () => _handleFollowPressed(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
