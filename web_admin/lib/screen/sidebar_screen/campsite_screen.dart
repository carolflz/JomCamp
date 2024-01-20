// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:web_admin/widget/display.dart';

// ignore: use_key_in_widget_constructors
class CampsiteScreen extends StatefulWidget {
  // ignore: unnecessary_string_escapes
  static const String routeName = '/Campsite';

  @override
  State<CampsiteScreen> createState() => _CampsiteScreenState();
}

class _CampsiteScreenState extends State<CampsiteScreen> {
  List<String> campID = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Text('Reservation Screen',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                )),
            DisplayWidget(),
          ],
        ));
  }
}
