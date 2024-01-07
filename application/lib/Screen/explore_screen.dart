import 'package:application/Ressuable_widget/banner_widget.dart';
import 'package:application/Ressuable_widget/category_text.dart';
import 'package:application/Ressuable_widget/search_text_widget.dart';
import 'package:application/Ressuable_widget/welcome_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:application/Ressuable_widget/google_map.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        WelcomeText(),
        SizedBox(
          height: 10,
        ),
        SearchText(),
        BannerWidget(),
        SizedBox(
          height: 10,
        ),
        MyMap(),
        SizedBox(
          height: 20,
        ),
        CategoryText(),
      ],
    ));
  }
}
