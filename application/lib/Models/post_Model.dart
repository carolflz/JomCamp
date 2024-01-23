import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String userName;
  Timestamp postDate;
  int likes;
  bool isLikedByUser;
  bool isFollowing;
  String imagePath;
  int ratings;
  String imageTitle;
  String documentId;
  late String formattedDate;

  Post({
    required this.userName,
    required this.postDate,
    this.likes = 0,
    this.isLikedByUser = false,
    this.isFollowing = false,
    this.imagePath = 'https://picsum.photos/200/300',
    this.ratings = 0,
    this.imageTitle = 'Found new campsite at Bukit Rimba',
    this.documentId = '',
  }) {
    // Convert Timestamp to String and store it in formattedDate
    formattedDate = postDate.toDate().toString();
  }
}
