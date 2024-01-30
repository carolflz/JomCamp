// PayPal Account Info
// sb-o4cxr28928219@personal.example.com
// 5X&$zDi)

import 'package:flutter/material.dart';
import 'package:application/Screen/booking_history_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class PaymentScreen extends StatefulWidget {
  final String bookingId;

  PaymentScreen({required this.bookingId});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String bookingDate = '';
  String bookingTime = '';
  int deliveryFee = 5;
  int equipmentFee = 0;
  int totalFee = 0;
  int campsiteFee = 0;
  String campsiteName = 'Fetching campsite...';
  List<Map<String, dynamic>> equipmentList = [];

  @override
  void initState() {
    super.initState();
    fetchBookingDetails();
  }

  Future<void> fetchBookingDetails() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> bookingDoc =
          await FirebaseFirestore.instance
              .collection('Booking')
              .doc(widget.bookingId)
              .get();

      var bookingData = bookingDoc.data();
      if (bookingData != null) {
        var campsiteId = bookingData['Campsite Id'];

        bookingDate = bookingData['Date'] ?? '';
        bookingTime = bookingData['Time'] ?? '';

        if (campsiteId != null) {
          var campsiteDoc = await FirebaseFirestore.instance
              .collection('google_map_campsites')
              .doc(campsiteId)
              .get();
          var campsiteData = campsiteDoc.data();
          setState(() {
            campsiteName = campsiteData?['Name'] ?? 'No campsite name found';
            campsiteFee = campsiteData?['Fee'] ?? 0;
            equipmentList = List<Map<String, dynamic>>.from(
                bookingData['equipments'] ?? []);
            equipmentFee = bookingData['totalEquipmentFee'] ?? 0;

            if (equipmentList.isEmpty) {
              deliveryFee = 0;
            } else {
              deliveryFee = 5;
            }

            totalFee = equipmentFee + deliveryFee + campsiteFee;
          });
        }
      } else {
        setState(() {
          campsiteName = 'Error: Booking data not found';
        });
      }
    } catch (e) {
      setState(() {
        campsiteName = 'Error loading campsite';
      });
      print("Error fetching booking details: $e");
    }
  }

  Widget buildBookingInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$campsiteName', style: TextStyle(fontSize: 18)),
        SizedBox(height: 4),
        Text('$bookingDate', style: TextStyle(fontSize: 16)),
        SizedBox(height: 2),
        Text('$bookingTime', style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildCartItems() {
    if (equipmentList.isEmpty) {
      return Text('The cart is empty', style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.5)));
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: equipmentList.length,
        itemBuilder: (context, index) {
          var item = equipmentList[index];
          return ListTile(
            title: Text('${item['name']} x ${item['quantity']}',
                style: TextStyle(color: Colors.black)),
            subtitle: Text('Price: RM ${item['equipmentFee']}',
                style: TextStyle(color: Colors.black.withOpacity(0.5))),
          );
        },
      );
    }
  }

  Widget buildPaymentDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
        Text('Campsite Fee     : RM $campsiteFee.00',
            style: TextStyle(fontSize: 16, color: Colors.black)),
        Text('Equipment Fee   : RM $equipmentFee.00',
            style: TextStyle(fontSize: 16, color: Colors.black)),
        Text('Delivery Fee        : RM $deliveryFee.00',
            style: TextStyle(fontSize: 16, color: Colors.black)),
        Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: const Divider(thickness: 2)),
        Text('Total Fee            : RM $totalFee.00',
            style: TextStyle(fontSize: 16, color: Colors.black)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Payment',
            style: TextStyle(
                fontSize: 25.0, letterSpacing: 2.0, color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/booking');
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Container(
        height: 800.0, // Set the desired height constraint here
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Booking Details:',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(height: 8),
                buildBookingInfo(),
                SizedBox(height: 12),
                Text('Cart Items:',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(height: 8),
                buildCartItems(),
                SizedBox(height: 12),
                Text('Payment Fees:',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(height: 8),
                buildPaymentDetails(),
                SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                      .collection('Booking')
                      .doc(widget.bookingId)
                      .update({'Status': 'Paid'});
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingHistoryScreen(),
                        ),
                      );
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => PaypalCheckout(
                          sandboxMode: true,
                          clientId:
                              "AchNfiVRLO77ypi4ygKbrkfuTrw6VsBmpZfYYe-Jzn79U1XUZ6yEDUtyUtoiFL-Na2jSwDh2yc65Ydb0",
                          secretKey:
                              "EDMVGkkcx4ISmeFaZqkT4DdbS7ovkZnn9_eNuPmqg6SSlLvsucttVspHe4aIZWFLxkwVSLD7G6KWk52Z",
                          returnURL: "success.snippetcoder.com",
                          cancelURL: "cancel.snippetcoder.com",
                          transactions: [
                            {
                              "amount": {
                                "total": totalFee.toStringAsFixed(2),
                                "currency": "MYR",
                                // "details": {
                                //   "campsite fee": campsiteFee.toStringAsFixed(2),
                                //   "equipment fee": equipmentFee.toStringAsFixed(2),
                                //   "delivery fee": deliveryFee.toStringAsFixed(2),
                                // }
                              },
                            }
                          ],                          
                          note: "Contact us for any questions on your order.",
                          onSuccess: (Map params) async {
                            print("onSuccess: $params");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingHistoryScreen(),
                                ),
                              );
                          },
                          onError: (error) {
                            print("onError: $error");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingHistoryScreen(),
                                ),
                              );
                            // Navigator.pop(context);
                          },
                          onCancel: () {
                            print('cancelled:');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingHistoryScreen(),
                                ),
                              );
                            // Navigator.pop(context);
                          },
                        ),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.all(10.0),
                      backgroundColor: Colors.black,
                      fixedSize: Size(200, 50),
                      textStyle: TextStyle(fontSize: 18, letterSpacing: 5.0),
                      shape: StadiumBorder(),
                    ),
                    child: Text("CHECKOUT"),
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
                      textStyle: TextStyle(fontSize: 18, letterSpacing: 5.0),
                      shape: StadiumBorder(),
                    ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}