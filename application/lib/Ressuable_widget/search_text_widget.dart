import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchText extends StatelessWidget {
  const SearchText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Search For Campsite',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
      
            prefixIcon: Icon(CupertinoIcons.search)
          ),
        ),
      ),
    );
  }
}