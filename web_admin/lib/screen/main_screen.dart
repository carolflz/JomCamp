// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:web_admin/screen/sidebar_screen/campsite_screen.dart';
import 'package:web_admin/screen/sidebar_screen/dashboard_screen.dart';
import 'package:web_admin/screen/sidebar_screen/rental_screen.dart';
import 'package:web_admin/screen/sidebar_screen/reservation_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // ignore: prefer_final_fields
  Widget _selectedItem = DashboardScreen();

  screenSelector(item) {
    switch (item.route) {
      case DashboardScreen.routeName:
        setState(() {
          _selectedItem = DashboardScreen();
        });
        break;
      case CampsiteScreen.routeName:
        setState(() {
          _selectedItem = CampsiteScreen();
        });
        break;
      case ReservationScreen.routeName:
        setState(() {
          _selectedItem = ReservationScreen();
        });
        break;
      case RentalScreen.routeName:
        setState(() {
          _selectedItem = RentalScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.yellow.shade900,
          title: const Text('Management'),
        ),
        sideBar: SideBar(
          items: const [
            AdminMenuItem(
                title: 'Dashboard',
                icon: Icons.dashboard,
                route: DashboardScreen.routeName),
            AdminMenuItem(
                title: 'CampSite',
                icon: Icons.location_on,
                route: CampsiteScreen.routeName),
            AdminMenuItem(
                title: 'Reservation',
                icon: Icons.bookmark,
                route: ReservationScreen.routeName),
            AdminMenuItem(
                title: 'Rental',
                icon: Icons.construction,
                route: RentalScreen.routeName),
          ],
          selectedRoute: '',
          onSelected: (item) {
            screenSelector(item);
          },
        ),
        body: _selectedItem);
  }
}
