import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:application/api/cart_provider.dart';

class CartScreen extends StatefulWidget {
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
    var userQuery = await FirebaseFirestore.instance.collection('users').limit(1).get();
    var userData = userQuery.docs.first.data() as Map<String, dynamic>;
    setState(() {
      equipmentList = userData['equipment'] ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Shopping Cart', style: TextStyle(fontSize: 25.0, letterSpacing: 2.0, color: Colors.white)),
        centerTitle: true,
        leading: IconButton(onPressed: () { 
          Navigator.pop(context);
        }, 
        icon: Icon(
          Icons.arrow_back
        ), 
        color: Colors.yellow.shade900,
        ),
      ),
      body: equipmentList.isEmpty
          ? Center(child: Text('No items in the cart', style: TextStyle(color: Colors.black)))
          : ListView.builder(
              itemCount: equipmentList.length,
              itemBuilder: (context, index) {
                var item = equipmentList[index];
                return buildCartItem(item, cartProvider);
              },
            ),
    );
  }

  Widget buildCartItem(Map<String, dynamic> item, CartProvider cartProvider) {
    return ListTile(
      title: Text('${item['name']}', style: TextStyle(fontSize: 18, color: Colors.black)),
      subtitle: Text('Price: RM ${item['equipmentFee']}', style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.5))),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () { 
              updateQuantity(item, cartProvider, -1);
            },
            color: Colors.yellow.shade900,
          ),
          Text('${item['quantity']}', style: TextStyle(fontSize: 18, color: Colors.white)),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () { 
              updateQuantity(item, cartProvider, 1);
            },
            color: Colors.yellow.shade900,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () { 
              removeItemFromCart(item, cartProvider);
            },
            color: Colors.yellow.shade900,
          ),
        ],
      ),
    );
  }

  void updateQuantity(Map<String, dynamic> item, CartProvider cartProvider, int change) async {
    var newQuantity = item['quantity'] + change;
    if (newQuantity <= 0) 
      return;

    var userQuery = await FirebaseFirestore.instance.collection('users').limit(1).get();
    var userDoc = userQuery.docs.first;

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(userDoc.reference);
      List<dynamic> equipmentList = List.from(snapshot['equipment']);

      var index = equipmentList.indexWhere((i) => i['id'] == item['id']);
      if (index != -1) {
        equipmentList[index]['quantity'] = newQuantity;
        transaction.update(userDoc.reference, {'equipment': equipmentList});
      }
    }).then((_) {
      cartProvider.addToCart(change);
      fetchEquipment(); 
    });
  }

  void removeItemFromCart(Map<String, dynamic> item, CartProvider cartProvider) async {
    var userQuery = await FirebaseFirestore.instance.collection('users').limit(1).get();
    var userDoc = userQuery.docs.first;

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(userDoc.reference);
      List<dynamic> equipmentList = List.from(snapshot['equipment']);

      equipmentList.removeWhere((i) => i['id'] == item['id']);
      transaction.update(userDoc.reference, {'equipment': equipmentList});
    }).then((_) {
      cartProvider.addToCart(-item['quantity']);
      fetchEquipment(); 
    });
  }
}
