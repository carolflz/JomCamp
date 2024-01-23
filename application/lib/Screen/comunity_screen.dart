import 'package:flutter/material.dart';
import 'package:application/Ressuable_widget/post_widget.dart';
import 'package:application/Ressuable_widget/search_text_widget.dart';
import 'package:application/Ressuable_widget/community_appbar_widget.dart';
import 'package:application/Screen/posts_screen.dart';
import 'package:application/Screen/profile_screen.dart';
import 'package:application/Screen/comunityflwing_screen.dart';
import 'package:application/Models/post_Model.dart';
import 'package:application/Screen/add_post_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComunityScreen extends StatefulWidget {
  @override
  _ComunityScreenState createState() => _ComunityScreenState();
}

class _ComunityScreenState extends State<ComunityScreen> {
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
            userName: doc['userId'], // Replace with your field names
            postDate: doc['postDate'], // Replace with your field names
            likes: doc['likes'], // Replace with your field names
            isLikedByUser:
                doc['isLikedByUser'], // Replace with your field names
            isFollowing: doc['isFollowing'], // Replace with your field names
            imagePath: doc['imagePath'], // Replace with your field names
            // ratings: doc['ratings'], // Replace with your field names
            imageTitle: doc['imageTitle'], // Replace with your field names
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

  void _navigateToAddPostScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPostScreen()),
    );
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

  void _commentPost(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _commentController = TextEditingController();
        return AlertDialog(
          title: Text("Comment on Post $index"),
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
              onPressed: () {
                // Here, you can handle the submission of the comment
                print("Comment: ${_commentController.text}"); // Example action
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Commented Post $index')),
                );
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
      appBar: CommunityAppBarWidget(
        onLocalButtonPressed: () {
          if (ModalRoute.of(context)?.settings.name != 'CommunityScreen') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ComunityScreen()),
            );
          }
        },
        onFollowingButtonPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ComunityFollowingScreen()),
          );
        },
        onAddPostPressed: _navigateToAddPostScreen,
        onNotificationsPressed: () {
          // Implement action for Notifications button
        },
      ),
      body: Column(
        children: [
          SearchText(), // Add SearchText widget here
          Expanded(
            child: ListView.builder(
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
                            builder: (context) => ProfileScreen()),
                      );
                    },
                    userName: posts[index].userName,
                    postDate: posts[index].formattedDate,
                    postIndex: index,
                    likes: posts[index].likes,
                    isLikedByUser: posts[index].isLikedByUser,
                    imagePath: posts[index].imagePath,
                    ratings: posts[index].ratings,
                    imageTitle: posts[index].imageTitle,
                    onLikePressed: (index) => _likePost(posts[index]),
                    onCommentPressed: _commentPost,
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
