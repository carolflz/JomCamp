// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/widget/display.dart';

class RentalScreen extends StatefulWidget {
  const RentalScreen({super.key});

  static const String routeName = '/Rental';

  @override
  State<RentalScreen> createState() => _RentalScreenState();
}

class _RentalScreenState extends State<RentalScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<dynamic> equipmentList = [];

  void fetchEquipment() async {
    var userQuery =
        await FirebaseFirestore.instance.collection('users').limit(1).get();
    var userData = userQuery.docs.first.data();
    setState(() {
      equipmentList = userData['equipment'] ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchEquipment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [Display(), Display(), Display(), Display()],
    ));
  }

  // Widget buildCartItem(Map<String, dynamic> item) {
  //   return ListTile(
  //     title: Text('${item['name']}',
  //         style: const TextStyle(fontSize: 18, color: Colors.black)),
  //     subtitle: Text('Price: RM ${item['equipmentFee']}',
  //         style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.5))),
  //     trailing: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         IconButton(
  //           icon: Icon(Icons.remove),
  //           onPressed: () {
  //             updateQuantity(item, cartProvider, -1);
  //           },
  //           color: Colors.yellow.shade900,
  //         ),
  //         Text('${item['quantity']}',
  //             style: TextStyle(fontSize: 18, color: Colors.white)),
  //         IconButton(
  //           icon: Icon(Icons.add),
  //           onPressed: () {
  //             updateQuantity(item, cartProvider, 1);
  //           },
  //           color: Colors.yellow.shade900,
  //         ),
  //         IconButton(
  //           icon: Icon(Icons.delete),
  //           onPressed: () {
  //             removeItemFromCart(item, cartProvider);
  //           },
  //           color: Colors.yellow.shade900,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
