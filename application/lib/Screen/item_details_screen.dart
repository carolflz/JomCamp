import 'package:application/Screen/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:application/api/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemDetailsScreen extends StatefulWidget {
  final DocumentSnapshot<Object?> item;

  ItemDetailsScreen({required this.item});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    String imageUrl = widget.item['Image'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Item Details',
          style: TextStyle(
            fontSize: 25.0,
            letterSpacing: 2.0,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.shopping_cart),
                color: Colors.black,
              ),
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    cartProvider.cartCount.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Column(
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.broken_image, size: 250),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.item['Type']}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.4),
                    letterSpacing: 3,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "${widget.item['Item Name']}",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 3,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Condition    :     ${widget.item['Condition']}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Brand          :     ${widget.item['Brand']}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Location      :     ${widget.item['Location']}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Contact       :     ${widget.item['Contact']}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 18),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        width: 120,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity--;
                                  }
                                });
                              },
                              child: Icon(
                                CupertinoIcons.minus,
                                size: 18,
                                color: Colors.yellow.shade900,
                              ),
                            ),
                            SizedBox(width: 15),
                            Text(
                              "$quantity",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 15),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: Icon(
                                CupertinoIcons.plus,
                                size: 18,
                                color: Colors.yellow.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "RM ${widget.item['Rental Price'] * quantity}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text("ADD TO CART"),
                        onPressed: () async {
                          try {
                            QuerySnapshot<Map<String, dynamic>> userQuery =
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .get();

                            if (userQuery.docs.isNotEmpty) {
                              DocumentSnapshot<Map<String, dynamic>> userDoc =
                                  userQuery.docs.first;

                              if (userDoc.exists) {
                                await FirebaseFirestore.instance
                                    .runTransaction((transaction) async {
                                  DocumentSnapshot<Map<String, dynamic>>
                                      freshUserDoc =
                                      await transaction.get(userDoc.reference);

                                  cartProvider.addToCart(quantity);

                                  if (freshUserDoc
                                      .data()!
                                      .containsKey('equipment')) {
                                    List<Map<String, dynamic>>
                                        currentEquipmentList =
                                        List.from(freshUserDoc['equipment']);

                                    int index = currentEquipmentList.indexWhere(
                                        (equipment) =>
                                            equipment['id'] == widget.item.id);

                                    if (index != -1) {
                                      currentEquipmentList[index]['quantity'] +=
                                          quantity;
                                      currentEquipmentList[index]
                                              ['equipmentFee'] =
                                          (widget.item['Rental Price'] as int) *
                                              currentEquipmentList[index]
                                                  ['quantity'];
                                    } else {
                                      currentEquipmentList.add({
                                        'id': widget.item.id,
                                        'name': widget.item['Item Name'],
                                        'price': widget.item['Rental Price'],
                                        'quantity': quantity,
                                        'equipmentFee': (widget
                                                .item['Rental Price'] as int) *
                                            quantity,
                                      });
                                    }

                                    int newTotalEquipmentFee =
                                        currentEquipmentList
                                            .map<int>(
                                                (equipment) =>
                                                    equipment['equipmentFee']
                                                        as int)
                                            .fold(
                                                0,
                                                (prev, current) =>
                                                    prev + current);

                                    transaction.update(userDoc.reference, {
                                      'equipment': currentEquipmentList,
                                      'totalEquipmentFee': newTotalEquipmentFee,
                                    });
                                  } else {
                                    transaction.update(userDoc.reference, {
                                      'equipment': [
                                        {
                                          'id': widget.item.id,
                                          'name': widget.item['Item Name'],
                                          'price': widget.item['Rental Price'],
                                          'quantity': quantity,
                                          'equipmentFee':
                                              (widget.item['Rental Price']
                                                      as int) *
                                                  quantity,
                                        },
                                      ],
                                      'totalEquipmentFee':
                                          (widget.item['Rental Price'] as int) *
                                              quantity,
                                    });
                                  }
                                });
                              } else {
                                print('No user document found.');
                              }
                            } else {
                              print('No user documents found.');
                            }
                          } catch (error) {
                            print('Error adding to cart: $error');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          backgroundColor: Colors.yellow.shade900,
                          fixedSize: Size(200, 50),
                          textStyle:
                              TextStyle(fontSize: 18, letterSpacing: 5.0),
                          shape: StadiumBorder(),
                        ),
                      ),
                      SizedBox(height: 18.0),
                      ElevatedButton(
                        child: Text("   CANCEL  "),
                        onPressed: () {
                          Navigator.pushNamed(context, '/rental');
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          backgroundColor: Colors.yellow.shade900,
                          fixedSize: Size(200, 50),
                          textStyle:
                              TextStyle(fontSize: 18, letterSpacing: 5.0),
                          shape: StadiumBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
