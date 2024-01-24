import 'package:application/Ressuable_widget/banner_widget.dart';
import 'package:application/Ressuable_widget/category_text.dart';
import 'package:application/Ressuable_widget/search_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:application/Ressuable_widget/google_map.dart';
import 'package:application/Ressuable_widget/level_camping.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            height: 80, // Adjust the height according to your design
            child: Image.asset(
              'assets/icons/JomCamp_br.png',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchText(),
          ),
          BannerWidget(),
          SizedBox(
            height: 10,
          ),
          MyMap(),
          SizedBox(
            height: 20,
          ),
          CategoryText(),
          LevelState(),
        ],
      ),
    );
  }
}
