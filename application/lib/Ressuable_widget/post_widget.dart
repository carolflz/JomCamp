import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:application/Ressuable_widget/followbtn_widget.dart';

class PostWidget extends StatelessWidget {
  final String userName;
  final String postDate;
  final int postIndex;
  final Function(int) onLikePressed;
  final Function(int) onCommentPressed;
  final String? imagePath;
  final String? location;
  final int ratings;
  final int likes;
  final bool isLikedByUser;
  final VoidCallback onUsernameTap;
  final bool isFollowing;
  final VoidCallback onFollowPressed;
  final String imageTitle;

  PostWidget({
    required this.userName,
    required this.postDate,
    required this.postIndex,
    required this.onLikePressed,
    required this.onCommentPressed,
    required this.likes,
    required this.isLikedByUser,
    required this.onUsernameTap,
    required this.isFollowing,
    required this.onFollowPressed,
    required this.ratings,
    required this.imageTitle,
    this.imagePath,
    this.location,
  });

  // List<Widget> _buildRatingStars(int rating) {
  //   List<Widget> stars = [];
  //   for (int i = 1; i <= 5; i++) {
  //     stars.add(
  //       Icon(
  //         i <= rating ? Icons.star : Icons.star_border,
  //         color: Color.fromARGB(255, 84, 83, 80),
  //       ),
  //     );
  //   }
  //   return stars;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: GestureDetector(
              onTap: onUsernameTap,
              child: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 30, 32, 30),
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                      onTap: onUsernameTap,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .doc(userName)
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
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            );
                          })),
                ),
                FollowButton(
                  isFollowing: isFollowing,
                  onFollowPressed: onFollowPressed,
                ),
                PopupMenuButton<String>(
                  onSelected: (String result) {
                    // Handle menu item click
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Report',
                      child: Text('Report'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Block',
                      child: Text('Block'),
                    ),
                  ],
                ),
              ],
            ),
            // subtitle: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            // children: [
            //   if (location != null) Text('Location: $location'),
            //   Text(postDate),
            // ],
            // ),
          ),
          if (imagePath != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                imagePath!,
                fit: BoxFit.cover,
                height: 200.0,
              ),
            ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              imageTitle, // Displaying the image title
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
          // Row(children: _buildRatingStars(ratings)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(
                  isLikedByUser ? Icons.favorite : Icons.favorite_border,
                  color: isLikedByUser ? Colors.red : null,
                ),
                onPressed: () => onLikePressed(postIndex),
              ),
              Text('$likes'),
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () => onCommentPressed(postIndex),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
