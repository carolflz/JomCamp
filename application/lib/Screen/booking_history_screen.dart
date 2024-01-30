import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:application/Models/constant.dart' as Constants;

class BookingHistoryScreen extends StatefulWidget {
  @override
  _BookingHistoryScreenState createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  List<Map<String, dynamic>> upcomingBookings = [];
  List<Map<String, dynamic>> previousBookings = [];

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  void fetchBookings() async {
    QuerySnapshot<Map<String, dynamic>> bookingQuery =
        await FirebaseFirestore.instance.collection('Booking').get();

    List<Map<String, dynamic>> tempUpcoming = [];
    List<Map<String, dynamic>> tempPrevious = [];

    for (var doc in bookingQuery.docs) {
      String userId = doc.data()['User Id']; // Get the User Id from Firestore

      if (userId == Constants.userId) {
        // Compare with the user id from constants.dart
        DateTime bookingDate =
            DateFormat('dd/MM/yyyy').parse(doc.data()['Date']);
        String campsiteId = doc.data()['Campsite Id'];

        DocumentSnapshot<Map<String, dynamic>> campsiteDoc =
            await FirebaseFirestore.instance
                .collection('google_map_campsites')
                .doc(campsiteId)
                .get();

        String campsiteName =
            campsiteDoc.data()?['Name'] ?? 'No campsite name found';

        Map<String, dynamic> booking = {
          ...doc.data(),
          'campsiteName': campsiteName,
          'id': doc.id,
        };

        if (doc.data().containsKey('Status') &&
            doc.data()['Status'] == 'Paid') {
          if (bookingDate.isAfter(DateTime.now())) {
            tempUpcoming.add(booking);
          } else {
            tempPrevious.add(booking);
          }
        }
      }
    }

    if (mounted) {
      setState(() {
        upcomingBookings = tempUpcoming;
        previousBookings = tempPrevious;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Booking History',
            style: TextStyle(
              fontSize: 25.0,
              letterSpacing: 2.0,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.yellow.shade900,
            unselectedLabelColor: Colors.black,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.yellow.shade900),
            ),
            tabs: [
              Tab(text: 'Upcoming Bookings'),
              Tab(text: 'Previous Bookings'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildBookingsList(upcomingBookings, isUpcoming: true),
            buildBookingsList(previousBookings, isUpcoming: false),
          ],
        ),
      ),
    );
  }

  Widget buildBookingsList(List<Map<String, dynamic>> bookings,
      {required bool isUpcoming}) {
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        var booking = bookings[index];
        return Card(
          child: ListTile(
            title: Text('${booking['campsiteName']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Date: ${booking['Date']}',
                    style: TextStyle(fontSize: 16)),
                Text('Time: ${booking['Time']}',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
            trailing: isUpcoming
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => removeBooking(booking),
                      ),
                    ],
                  )
                : null,
          ),
        );
      },
    );
  }

  void editBooking(Map<String, dynamic> booking) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateFormat('dd/MM/yyyy').parse(booking['Date']),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (newDate != null) {
      TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(DateFormat('HH:mm').parse(booking['Time'])),
      );

      if (newTime != null) {
        updateBookingInFirestore(booking, newDate, newTime);
      }
    }
  }

  void updateBookingInFirestore(
      Map<String, dynamic> booking, DateTime newDate, TimeOfDay newTime) async {
    await FirebaseFirestore.instance
        .collection('Booking')
        .doc(booking['id'])
        .update({
      'Date': DateFormat('dd/MM/yyyy').format(newDate),
      'Time': newTime.format(context),
    });

    setState(() {
      booking['Date'] = DateFormat('dd/MM/yyyy').format(newDate);
      booking['Time'] = newTime.format(context);
    });
  }

  void removeBooking(Map<String, dynamic> booking) async {
    bool confirmDelete = await showDeleteConfirmationDialog(context);

    if (confirmDelete) {
      final campsite = FirebaseFirestore.instance.collection('Cancel').doc();
      final json = {'Booking Id': booking['id']};
      await campsite.set(json);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
        padding: const EdgeInsets.all(8),
        height: 85,
        decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(children: [
          Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 40,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Request Send",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "Your Cancelation Request has been send. Waiting for approval.",
                style: TextStyle(color: Colors.white, fontSize: 15),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ))
        ]),
      )));
    }
  }

  Future<bool> showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirm Deletion"),
              content: Text("Are you sure you want to delete this booking?"),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                ElevatedButton(
                    child: Text("Delete"),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    }),
              ],
            );
          },
        ) ??
        false;
  }
}
