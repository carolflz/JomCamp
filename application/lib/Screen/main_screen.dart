import 'package:application/Screen/booking_history_screen.dart';
import 'package:application/Screen/booking_screen.dart';
import 'package:application/Screen/comunity_screen.dart';
import 'package:application/Screen/explore_screen.dart';
import 'package:application/Screen/navigate_screen.dart';
import 'package:application/Screen/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 int _pageIndex = 0;
 
 List<Widget> _pages = [
  ExploreScreen(),
  //NavigateScreen(),
  BookingScreen(),
  ComunityScreen(),
  BookingHistoryScreen(),
  ProfileScreen(),
 ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        onTap: (value){
          setState(() {
            _pageIndex = value;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.yellow.shade900,
        items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search), //SvgPicture.asset('assets/icons/', width: 20)
          label: 'Explore', 
          ),

          BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.cart_fill), 
          label: 'Navigator', 
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

       body: _pages[_pageIndex]
    );
  }
}