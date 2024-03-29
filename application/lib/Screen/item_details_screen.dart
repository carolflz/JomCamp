import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:application/api/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:application/Screen/cart_screen.dart';

class ItemDetailsScreen extends StatefulWidget {
  final DocumentSnapshot<Object?> item;
  final String bookingId;


  ItemDetailsScreen({required this.item, required this.bookingId});

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
                      builder: (context) => CartScreen(bookingId: widget.bookingId),
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
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(15.0), // Set the corner radius here
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.broken_image, size: 250),
              ),
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
                  "${widget.item['Name']}",
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
                  "Brand           :     ${widget.item['Brand']}",
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
                                color: Color.fromARGB(255, 3, 61, 5),
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
                                color: Color.fromARGB(255, 3, 61, 5),
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
                          await addToBooking();
                          Provider.of<CartProvider>(context, listen: false).addToCart(quantity);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          backgroundColor: Colors.black,
                          fixedSize: Size(200, 50),
                          textStyle:
                              TextStyle(fontSize: 18, letterSpacing: 5.0),
                          shape: StadiumBorder(),
                        ),
                      ),
                      SizedBox(height: 18.0),
                      ElevatedButton(
                        child: Text("CANCEL"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          backgroundColor: Color.fromARGB(255, 3, 61, 5),
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

    Future<void> addToBooking() async {
    try {
      // Reference to the specific booking document
      DocumentReference bookingRef = FirebaseFirestore.instance.collection('Booking').doc(widget.bookingId);

      FirebaseFirestore.instance.runTransaction((transaction) async {
        // Get the current booking document
        DocumentSnapshot bookingSnapshot = await transaction.get(bookingRef);

        // Get the current equipment list from the booking, if it exists
        List<dynamic> currentEquipment = (bookingSnapshot.data() as Map<String, dynamic>)['equipments'] ?? [];

        // Check if the item already exists in the list
        int existingIndex = currentEquipment.indexWhere((equip) => equip['id'] == widget.item.id);
        if (existingIndex != -1) {
          // Update quantity and equipment fee if it already exists
          currentEquipment[existingIndex]['quantity'] += quantity;
          currentEquipment[existingIndex]['equipmentFee'] += quantity * widget.item['Rental Price'];
        } else {
          // Add the new equipment to the list if it doesn't exist
          currentEquipment.add({
            'id': widget.item.id,
            'name': widget.item['Name'],
            'price': widget.item['Rental Price'],
            'quantity': quantity,
            'equipmentFee': quantity * widget.item['Rental Price'],
          });
        }

        int newTotalEquipmentFee = currentEquipment.fold<int>(0, (int previousValue, dynamic element) {
          return previousValue + (element['equipmentFee'] as int);
        });

        // Update the booking document with the new equipment list and total fee
        transaction.update(bookingRef, {
          'equipments': currentEquipment,
          'totalEquipmentFee': newTotalEquipmentFee,
        });
      });

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Equipment added to booking.'),
      backgroundColor: Colors.green, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), 
      ),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.white, 
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );

    } catch (e) {
      print('Error updating booking: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add equipment to booking.'),
        backgroundColor: Colors.red,
      ));
    }
  }
}