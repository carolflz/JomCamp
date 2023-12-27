import 'package:flutter/cupertino.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:  EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 25, right: 25),
        child: Row(children: [ 
          Text('JomCamp')
        ],
      ),
    ); 
  }
}