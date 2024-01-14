import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchText extends StatelessWidget {
  const SearchText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Color(0xFFD2B48C), // Light Goldenrod Yellow color
          child: TextField(
            style: TextStyle(color: Colors.black), // Text color
            decoration: InputDecoration(
              hintText: 'Search For Campsite',
              border: InputBorder.none, // No border
              prefixIcon: Icon(
                CupertinoIcons.search,
                color: Colors.black, // Icon color
              ),
            ),
          ),
        ),
      ),
    );
  }
}
