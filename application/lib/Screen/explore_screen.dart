import 'package:flutter/cupertino.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Padding(
        padding:  EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 25, right: 25),
        child: Row(children: [ 
          Text('JomCamp',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),) 
        ],
      ),
    ); 
  }
}