// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:web_admin/widget/cancel.dart';

// ignore: use_key_in_widget_constructors
class CancelScreen extends StatefulWidget {
  // ignore: unnecessary_string_escapes
  static const String routeName = '/Cancel';

  @override
  State<CancelScreen> createState() => _CancelScreenState();
}

class _CancelScreenState extends State<CancelScreen> {
  List<String> bookID = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                Text('Booking Cancelation',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                    )),
              ],
            ),
            DisplayWidget(),
          ],
        ));
  }
}
