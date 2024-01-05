// ignore_for_file: prefer_const_constructors

import 'package:application_back_up/Ressuable_widget/banner_widget.dart';
import 'package:application_back_up/Ressuable_widget/category_text.dart';
import 'package:application_back_up/Ressuable_widget/search_text_widget.dart';
import 'package:application_back_up/Ressuable_widget/welcome_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WelcomeText(),
        SizedBox(
          height: 10,
        ),
        SearchText(),
        BannerWidget(),
        CategoryText(),
      ],
    );
  }
}
