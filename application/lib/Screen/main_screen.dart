import 'package:application/Models/constant.dart';
import 'package:application/Screen/booking_history_screen.dart';
import 'package:application/Screen/comunity_screen.dart';
import 'package:application/Screen/comunityflwing_screen.dart';
import 'package:application/Screen/explore_screen.dart';
import 'package:application/Screen/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  final int value;
  const MainScreen({super.key, required this.value});

  @override
  State<MainScreen> createState() => _MainScreenState(value);
}

class _MainScreenState extends State<MainScreen> {
  _MainScreenState(this._pageIndex);
  int _pageIndex = 0;

  List<Widget> _pages = [
    ExploreScreen(),
    ComunityScreen(),
    BookingHistoryScreen(),
    ProfileScreen(
      userID: userId,
    ),
    ComunityFollowingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _pageIndex,
          onTap: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.yellow.shade900,
          items: [
            BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons
                  .search_location), //SvgPicture.asset('assets/icons/', width: 20)
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_2),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bookmark),
              label: 'Booking',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_crop_circle),
              label: 'Profile',
            ),
          ],
        ),
        body: _pages[_pageIndex]);
  }
}
