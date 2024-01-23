import 'package:application/Screen/comunityflwing_screen.dart';
import 'package:application/Screen/comunitylocal_screen.dart';
import 'package:flutter/material.dart';
import 'package:application/Screen/add_post_screen.dart';

void _navigateToAddPostScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddPostScreen()),
  );
}

class ComunityScreen extends StatefulWidget {
  const ComunityScreen({super.key});

  @override
  State<ComunityScreen> createState() => _ComunityScreenState();
}

class _ComunityScreenState extends State<ComunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Community',
              style: TextStyle(
                fontSize: 25.0,
                letterSpacing: 2.0,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            bottom: TabBar(
              labelColor: Colors.yellow.shade900,
              unselectedLabelColor: Colors.black,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.yellow.shade900),
              ),
              tabs: [
                Tab(text: 'Local'),
                Tab(text: 'Following'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ComunityLocalScreen(),
              ComunityFollowingScreen(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () => _navigateToAddPostScreen(context),
              backgroundColor: Color.fromARGB(255, 245, 137, 70),
              tooltip: 'Add Post',
              child: Icon(Icons.add)),
        ),
      ),
    );
  }
}
