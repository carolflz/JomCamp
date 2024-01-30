import 'package:application/Models/constant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:application/Models/post_Model.dart';
import 'package:application/Ressuable_widget/post_widget.dart';
import 'package:application/Screen/profile_screen.dart';
import 'package:application/Screen/posts_screen.dart';

class ComunityFollowingScreen extends StatefulWidget {
  @override
  _ComunityFollowingScreenState createState() =>
      _ComunityFollowingScreenState();
}

class _ComunityFollowingScreenState extends State<ComunityFollowingScreen> {
  List<Post> followingPosts = [];

  void _fetchFollowingPosts() {
    FirebaseFirestore.instance
        .collection('Post')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      setState(() {
        followingPosts = querySnapshot.docs
            .map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return Post(
                userName: doc['userId'], // Replace with your field names
                postDate: data['postDate'], // Replace with your field names
                likes: data['likes'], // Replace with your field names
                isLikedByUser:
                    data['isLikedByUser'], // Replace with your field names
                isFollowing:
                    data['isFollowing'], // Replace with your field names
                imagePath: data['imagePath'], // Replace with your field names
                imageTitle: data['imageTitle'], // Replace with your field names
                documentId: doc.id, // Store the document ID
              );
            })
            .where((post) => post.isFollowing == true)
            .toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchFollowingPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 5),
              itemCount: followingPosts.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostsScreen(
                            postIndex: index, posts: followingPosts),
                      ),
                    );
                  },
                  child: PostWidget(
                    onUsernameTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                                  userID: userId,
                                )),
                      );
                    },
                    userName: followingPosts[index].userName,
                    postDate: followingPosts[index].formattedDate,
                    postIndex: index,
                    likes: followingPosts[index].likes,
                    isLikedByUser: followingPosts[index].isLikedByUser,
                    imagePath: followingPosts[index].imagePath,
                    ratings: followingPosts[index].ratings,
                    imageTitle: followingPosts[index].imageTitle,
                    onLikePressed: (index) => _likePost(followingPosts[index]),
                    onCommentPressed: (index) => _commentPost(
                      context,
                      index,
                      followingPosts[index].documentId,
                    ),
                    isFollowing: followingPosts[index].isFollowing,
                    onFollowPressed: () => _handleFollowPressed(index),
                    id: followingPosts[index].documentId,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _likePost(Post post) {
    setState(() {
      _toggleLike(post);
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
      post.isLikedByUser = false;
      post.likes--;
      final postRef =
          FirebaseFirestore.instance.collection('Post').doc(post.documentId);
      postRef.update({
        'isLikedByUser': false,
        'likes': FieldValue.increment(-1),
      });
    } else {
      post.isLikedByUser = true;
      post.likes++;
      final postRef =
          FirebaseFirestore.instance.collection('Post').doc(post.documentId);
      postRef.update({
        'isLikedByUser': true,
        'likes': FieldValue.increment(1),
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
      followingPosts[index].isFollowing = !followingPosts[index].isFollowing;
    });
  }
}
