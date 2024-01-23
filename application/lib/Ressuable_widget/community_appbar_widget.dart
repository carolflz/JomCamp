import 'package:flutter/material.dart';

class CommunityAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onLocalButtonPressed;
  final VoidCallback onFollowingButtonPressed;
  final VoidCallback onAddPostPressed;
  final VoidCallback onNotificationsPressed;

  CommunityAppBarWidget({
    required this.onLocalButtonPressed,
    required this.onFollowingButtonPressed,
    required this.onAddPostPressed,
    required this.onNotificationsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          TextButton(
            onPressed: onLocalButtonPressed,
            child: Text('Local',
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
          ),
          TextButton(
            onPressed: onFollowingButtonPressed,
            child: Text('Following',
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
          ),
          // Other AppBar elements can follow here if needed
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: onAddPostPressed,
        ),
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: onNotificationsPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
