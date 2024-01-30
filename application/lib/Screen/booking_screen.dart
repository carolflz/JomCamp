// ignore_for_file: unnecessary_null_comparison

import 'package:application/Screen/payment_screen.dart';
import 'package:application/Screen/rental_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:application/api/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  final String bookingId;

  BookingScreen(this.bookingId);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  String campsiteName = '';
  int campsitePrice = 0;
  String imageUrl = '';
  String id = '';

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
    fetchCampsiteInfo();
  }

  Future<void> fetchCampsiteInfo() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> bookingDoc =
          await FirebaseFirestore.instance
              .collection('Booking')
              .doc(widget.bookingId)
              .get();

      String campsiteId = bookingDoc.data()?['Campsite Id'];

      if (campsiteId != null) {
        DocumentSnapshot<Map<String, dynamic>> campsiteDoc =
            await FirebaseFirestore.instance
                .collection('google_map_campsites')
                .doc(campsiteId)
                .get();

        setState(() {
          campsiteName =
              campsiteDoc.data()?['Name'] ?? 'No campsite name found';
          campsitePrice = campsiteDoc.data()?['Fee'] ?? 0;
          imageUrl = campsiteDoc.data()?['image'] ?? '';
        });
      }
    } catch (e) {
      print('Error fetching campsite details: $e');
      setState(() {
        campsiteName = 'Error loading campsite name';
      });
    }
  }

  Widget build(BuildContext context) {
    int cartCounter = Provider.of<CartProvider>(context).cartCount;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Booking Details',
          style: TextStyle(
            fontSize: 25.0,
            letterSpacing: 2.0,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            cancelBooking();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 250,
              width: double.infinity,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(15.0), // Set the corner radius here
                child: imageUrl.isNotEmpty
                    ? Image.network(imageUrl, fit: BoxFit.cover)
                    : Container(
                        color: Colors.black.withOpacity(0.2),
                        child:
                            Icon(Icons.image, size: 128, color: Colors.white),
                      ),
              ),
            ),
            SizedBox(height: 14.0),
            Text(
              '$campsiteName',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'RM${campsitePrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () async {
                    final DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(3000),
                    );
                    if (dateTime != null) {
                      setState(() {
                        selectedDate = dateTime;
                      });
                    }
                  },
                  icon: Icon(Icons.calendar_month_outlined),
                  label: Text(
                      ' SELECT DATE    -    ${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year} '),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              ElevatedButton.icon(
                onPressed: () async {
                  final TimeOfDay? timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (timeOfDay != null) {
                    setState(() {
                      selectedTime = timeOfDay;
                    });
                  }
                },
                icon: Icon(Icons.access_time),
                label: Text(
                    '   SELECT TIME    -    ${selectedTime.format(context)}    '),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
              ),
            ]),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    // Use widget.bookingId, which is the ID passed to this screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            RentalScreen(bookingId: widget.bookingId),
                      ),
                    );
                  },
                  icon: Icon(Icons.shopping_cart),
                  label: Text('ADD CAMPING EQUIPMENT ($cartCounter)'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text("CONFIRM"),
                    onPressed: () async {
                      await addBooking(
                          selectedDate, selectedTime.format(context));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PaymentScreen(bookingId: widget.bookingId),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.all(10.0),
                      fixedSize: Size(200, 50),
                      textStyle: TextStyle(fontSize: 18, letterSpacing: 5.0),
                      shape: StadiumBorder(),
                    ),
                  ),
                  SizedBox(height: 18.0),
                  ElevatedButton(
                    child: Text("CANCEL"),
                    onPressed: () {
                      cancelBooking();
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
    );
  }

  Future<void> addBooking(DateTime selectedDate, String selectedTime) async {
    try {
      DocumentReference bookingRef = FirebaseFirestore.instance
          .collection('Booking')
          .doc(widget.bookingId);

      await bookingRef.update({
        'Date': DateFormat('dd/MM/yyyy').format(selectedDate),
        'Time': selectedTime,
      });
    } catch (e) {
      print(
          'An error occurred while adding the date and time to the booking: $e');
    }
  }

  Future<void> cancelBooking() async {
    try {
      DocumentReference bookingRef = FirebaseFirestore.instance
          .collection('Booking')
          .doc(widget.bookingId);

      await bookingRef.delete();

      Navigator.pop(context);
    } catch (e) {
      print('An error occurred while canceling the booking: $e');
    }
  }
}
