import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:application/api/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {

  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  String campsiteName = '';
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
    fetchCampsiteInfo();
  }

  Future<void> fetchCampsiteInfo() async {
    try {
      // Fetch the first document from the 'users' collection
      QuerySnapshot<Map<String, dynamic>> userQuery = await FirebaseFirestore.instance.collection('users').limit(1).get();

      if (userQuery.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> userDoc = userQuery.docs.first;
        List<Map<String, dynamic>> bookingDetails = 
            (userDoc.data()?['bookings'] as List?)?.cast<Map<String, dynamic>>() ?? [];

        if (bookingDetails.isNotEmpty) {
          setState(() {
            campsiteName = bookingDetails.last['campsite'] ?? 'No campsite name found';
            imageUrl = bookingDetails.last['image'] ?? ''; 
          });
        }
      }
    } catch (e) {
      setState(() {
        campsiteName = 'Error loading campsite name';
        imageUrl = 'Error loading campsite image';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load campsite details. Please try again later.')),
      );
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
              child: imageUrl.isNotEmpty 
                ? Image.network(imageUrl, fit: BoxFit.cover)
                : Container( 
                    color: Colors.yellow.shade900,
                    child: Icon(Icons.image, size: 128, color: Colors.white),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () async {
                    final DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(3000),
                    );
                    if (dateTime != null) {
                      setState(() {
                        selectedDate = dateTime;
                      });
                    }
                  },
                  icon: Icon(Icons.calendar_month_outlined),
                  label: Text(' SELECT DATE    -    ${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year} '),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow.shade900,
                    onPrimary: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[            
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
                  label: Text('   SELECT TIME    -    ${selectedTime.format(context)}    '),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow.shade900,
                    onPrimary: Colors.white,
                  ),
                ),
              ]
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      Navigator.pushNamed(context, '/rental');
                    });
                  },
                  icon: Icon(Icons.shopping_cart),
                  label: Text('ADD CAMPING EQUIPMENT ($cartCounter)'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow.shade900,
                    onPrimary: Colors.white,
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
                      await updateBooking(selectedDate, selectedTime.format(context));
                      Navigator.pushNamed(context, '/payment');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10.0),
                      fixedSize: Size(200, 50),
                      textStyle: TextStyle(fontSize: 18, letterSpacing: 5.0),
                      primary: Colors.yellow.shade900,
                      onPrimary: Colors.white,
                      shape: StadiumBorder(),
                    ),
                  ),
                  SizedBox(height: 18.0),             
                  ElevatedButton(
                    child: Text("CANCEL"),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10.0),
                      fixedSize: Size(200, 50),
                      textStyle: TextStyle(fontSize: 18, letterSpacing: 5.0),
                      primary: Colors.yellow.shade900,
                      onPrimary: Colors.white,
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

  Future<void> updateBooking(DateTime date, String time) async {
    QuerySnapshot<Map<String, dynamic>> userQuery =
        await FirebaseFirestore.instance.collection('users').get();

    if (userQuery.docs.isNotEmpty) {
      DocumentSnapshot<Map<String, dynamic>> userDoc = userQuery.docs.first;

      var rawBookings = userDoc.data()?['bookings'];
      List<Map<String, dynamic>> existingBookings;
      if (rawBookings is List<dynamic>) {
        existingBookings = rawBookings.map((item) => item as Map<String, dynamic>).toList();
      } else {
        existingBookings = <Map<String, dynamic>>[];
      }

      existingBookings.add({
        'date': DateFormat('dd/MM/yyyy').format(date),
        'time': time,
      });

      userDoc.reference.update({
        'bookings': existingBookings,
      });
    } else {
      await FirebaseFirestore.instance.collection('users').add({
        'bookings': [
          {
            'date': DateFormat('dd/MM/yyyy').format(date),
            'time': time,
          },
        ],
      });
    }
  }
}
