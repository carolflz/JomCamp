import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        title: const Text('Management'),
      ),
      sideBar: const SideBar(
        items: [
          AdminMenuItem(title: 'CampSite', icon: Icons.location_on, route: '/'),
          AdminMenuItem(title: 'Reservation', icon: Icons.bookmark, route: '/'),
          AdminMenuItem(title: 'Rental', icon: Icons.construction, route: '/'),
        ],
        selectedRoute: '',
      ),
      body: const Center(child: Text('Dashboard')),
    );
  }
}
