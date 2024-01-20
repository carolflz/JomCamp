// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:web_admin/class/constant.dart';
import 'package:web_admin/screen/sidebar_screen/campsite_screen.dart';
import 'package:web_admin/screen/sidebar_screen/rental_screen.dart';
import 'package:web_admin/screen/sidebar_screen/reservation_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // ignore: prefer_final_fields
  Widget _selectedItem = CampsiteScreen();

  screenSelector(item) {
    switch (item.route) {
      case CampsiteScreen.routeName:
        setState(() {
          _selectedItem = CampsiteScreen();
        });
        break;
      case RentalScreen.routeName:
        setState(() {
          _selectedItem = RentalScreen();
        });
        break;
      case ReservationScreen.routeName:
        setState(() {
          _selectedItem = ReservationScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Center(
            child: Text(
              'JOMCAMP',
              style: GoogleFonts.ubuntu(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ),
        sideBar: SideBar(
          items: const [
            AdminMenuItem(
                title: 'CampSite',
                icon: LineAwesomeIcons.campground,
                route: CampsiteScreen.routeName),
            AdminMenuItem(
                title: 'Rental Equipment',
                icon: LineAwesomeIcons.binoculars,
                route: RentalScreen.routeName),
            AdminMenuItem(
                title: 'Campsite Booking',
                icon: LineAwesomeIcons.alternate_map_marked,
                route: ReservationScreen.routeName),
          ],
          selectedRoute: '',
          onSelected: (item) {
            screenSelector(item);
          },
          header: Container(
            height: 50,
            width: double.infinity,
            color: const Color(0xff444444),
            child: Center(
              child: Text(
                'Management',
                style: GoogleFonts.ubuntu(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
          footer: Container(
            height: 50,
            width: double.infinity,
            color: const Color(0xff444444),
            child: const Center(
              child: Text(
                'By Group26',
                style:
                    TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ),
        body: _selectedItem);
  }
}
