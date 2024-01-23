import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onFollowPressed;

  const FollowButton({
    Key? key,
    required this.isFollowing,
    required this.onFollowPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(isFollowing ? Icons.check : Icons.person_add),
      label: Text(isFollowing ? 'Following' : 'Follow'),
      onPressed: onFollowPressed,
      style: TextButton.styleFrom(
        foregroundColor:
            isFollowing ? Colors.black : const Color.fromARGB(255, 4, 98, 0),
      ),
    );
  }
}
