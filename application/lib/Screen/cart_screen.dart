import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:application/api/cart_provider.dart';

class CartScreen extends StatefulWidget {
  final String bookingId;

  CartScreen({required this.bookingId});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<dynamic> equipmentList = [];

  @override
  void initState() {
    super.initState();
    fetchEquipment();
  }

  void fetchEquipment() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> bookingDoc =
          await FirebaseFirestore.instance.collection('Booking').doc(widget.bookingId).get();

      if (bookingDoc.exists) {
        var bookingData = bookingDoc.data();
        if (bookingData != null && bookingData.containsKey('equipments')) {
          setState(() {
            equipmentList = bookingData['equipments'] ?? [];
          });
        } else {
          setState(() {
            equipmentList = [];
          });
        }
      } else {
        setState(() {
          equipmentList = [];
        });
      }
    } catch (e) {
      print("Error fetching equipment: $e");
      setState(() {
        equipmentList = [];
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Shopping Cart',
            style: TextStyle(
                fontSize: 25.0, letterSpacing: 2.0, color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Color.fromARGB(255, 3, 61, 5),
        ),
      ),
      body: equipmentList.isEmpty
          ? Center(
              child: Text('No items in the cart',
                  style: TextStyle(color: Colors.black)))
          : Container(
              height: 800.0, 
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: equipmentList.length,
                  itemBuilder: (context, index) {
                    var item = equipmentList[index];
                    return buildCartItem(item, cartProvider);
                  },
                ),
              ),
            ),
    );
  }

  Widget buildCartItem(Map<String, dynamic> item, CartProvider cartProvider) {
    return ListTile(
      title: Text('${item['name']}',
          style: TextStyle(fontSize: 18, color: Colors.black)),
      subtitle: Text('Price: RM ${item['equipmentFee']}',
          style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.5))),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              updateQuantity(item, cartProvider, -1);
            },
            color: Color.fromARGB(255, 3, 61, 5),
          ),
          Text('${item['quantity']}',
              style: TextStyle(fontSize: 18, color: Colors.black)),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              updateQuantity(item, cartProvider, 1);
            },
            color: Color.fromARGB(255, 3, 61, 5),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              removeItemFromCart(item, cartProvider);
            },
            color: Color.fromARGB(255, 3, 61, 5),
          ),
        ],
      ),
    );
  }

  void updateQuantity(Map<String, dynamic> item, CartProvider cartProvider, int change) async {
    var newQuantity = item['quantity'] + change;
    if (newQuantity <= 0) return;

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(
          FirebaseFirestore.instance.collection('Booking').doc(widget.bookingId));
      List<dynamic> equipmentList = List.from(snapshot['equipments']);

      var index = equipmentList.indexWhere((i) => i['id'] == item['id']);
      int totalEquipmentFee = 0;

      if (index != -1) {
        equipmentList[index]['quantity'] = newQuantity;
        equipmentList[index]['equipmentFee'] = newQuantity * (equipmentList[index]['price'] as int);

        totalEquipmentFee = equipmentList.fold(0, (total, current) {
          int equipmentFee = current['equipmentFee'] is int ? current['equipmentFee'] : 0;
          return total + equipmentFee;
        });

        transaction.update(snapshot.reference, {
          'equipments': equipmentList,
          'totalEquipmentFee': totalEquipmentFee
        });
      }
    }).then((_) {
      cartProvider.addToCart(change);
      fetchEquipment(); // Fetch updated equipment list
    });
  }

  void removeItemFromCart(Map<String, dynamic> item, CartProvider cartProvider) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(
          FirebaseFirestore.instance.collection('Booking').doc(widget.bookingId));
      List<dynamic> equipmentList = List.from(snapshot['equipments']);

      equipmentList.removeWhere((i) => i['id'] == item['id']);

      transaction.update(snapshot.reference, {'equipments': equipmentList});
    }).then((_) {
      cartProvider.addToCart(-item['quantity']);
      fetchEquipment();
    });
  }
}
