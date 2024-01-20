// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_admin/screen/add_campsite_screen.dart';
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
            Row(
              children: [
                Text('Campsite Screen',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                    )),
                SizedBox(
                  width: 850,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCampsiteScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: Center(
                      child: Text(
                        'Add Campsite',
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            DisplayWidget(),
          ],
        ));
  }
}
