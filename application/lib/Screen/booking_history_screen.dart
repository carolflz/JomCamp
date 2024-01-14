import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BookingHistoryScreen extends StatefulWidget {
  @override
  _BookingHistoryScreenState createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> _userStream =
      FirebaseFirestore.instance.collection('users').limit(1).snapshots();

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
          // leading: IconButton(
          //   onPressed: () => Navigator.pop(context),
          //   icon: Icon(Icons.arrow_back, color: Colors.black),
          // ),
          bottom: TabBar(
            labelColor: Colors.yellow.shade900,
            unselectedLabelColor: Colors.black,
            isScrollable: true,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Colors.yellow.shade900,
              ),
            ),
            tabs: [
              Tab(text: 'Upcoming Bookings'),
              Tab(text: 'Previous Bookings'),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _userStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var userDocuments = snapshot.data!.docs;
              return buildBookingsTabs(userDocuments);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget buildBookingsTabs(List<QueryDocumentSnapshot<Map<String, dynamic>>> userDocuments) {
    List<Map<String, dynamic>> upcomingBookings = [];
    List<Map<String, dynamic>> previousBookings = [];

    for (var userDocument in userDocuments) {
      List<Map<String, dynamic>> bookingDetails =
          (userDocument.data()?['bookings'] as List?)?.cast<Map<String, dynamic>>() ?? [];

      for (var booking in bookingDetails) {
        DateTime bookingDate = DateFormat('dd/MM/yyyy').parse(booking['date']);

        if (bookingDate.isAfter(DateTime.now())) {
          upcomingBookings.add(booking);
        } else {
          previousBookings.add(booking);
        }
      }
    }

    return Expanded(
      child: TabBarView(
        children: [
          buildBookingsList(upcomingBookings, isUpcoming: true),
          buildBookingsList(previousBookings, isUpcoming: false),
        ],
      ),
    );
  }

  Widget buildBookingsList(List<Map<String, dynamic>> bookings, {required bool isUpcoming}) {
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        var booking = bookings[index];
        return ListTile(
          title: Text('${booking['campsite']}', style: TextStyle(fontSize: 18, color: Colors.black)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date : ${booking['date']}',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                'Time : ${booking['time']}',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              if (isUpcoming)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        editBooking(booking);
                      },
                      icon: Icon(Icons.edit),
                      label: Text('EDIT', style: TextStyle(fontSize: 12)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow.shade900,
                        onPrimary: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        removeBooking(booking);
                      },
                      icon: Icon(Icons.delete),
                      label: Text('REMOVE', style: TextStyle(fontSize: 12)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow.shade900,
                        onPrimary: Colors.white,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> buildBookingStream() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _userStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userDocuments = snapshot.data!.docs;
          return buildBookingsTabs(userDocuments);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  void editBooking(Map<String, dynamic> booking) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateFormat('dd/MM/yyyy').parse(booking['date']),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (newDate != null) {
      TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateFormat('dd/MM/yyyy').parse(booking['date'])),
      );

      if (newTime != null) {
        updateBookingInFirestore(booking, newDate, newTime);
      }
    }
  }

  void updateBookingInFirestore(Map<String, dynamic> booking, DateTime newDate, TimeOfDay newTime) {
    FirebaseFirestore.instance.collection('users').get().then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        var userBookings = List<Map<String, dynamic>>.from(document.data()['bookings']);

        // Find the index of the booking to be updated
        int bookingIndex = userBookings.indexWhere((b) =>
            b['campsite'] == booking['campsite'] &&
            b['date'] == booking['date'] &&
            b['time'] == booking['time']);
        
        if (bookingIndex != -1) {
          // Update the booking details
          userBookings[bookingIndex]['date'] = DateFormat('dd/MM/yyyy').format(newDate);
          userBookings[bookingIndex]['time'] = '${newTime.format(context)}';

          // Update the document
          document.reference.update({'bookings': userBookings});
        }
      });
    });
  }

  void removeBooking(Map<String, dynamic> booking) {
    FirebaseFirestore.instance.collection('users').get().then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        var userBookings = List<Map<String, dynamic>>.from(document.data()['bookings']);

        // Remove the booking
        userBookings.removeWhere((b) =>
            b['campsite'] == booking['campsite'] &&
            b['date'] == booking['date'] &&
            b['time'] == booking['time']);

        // Update the document
        document.reference.update({'bookings': userBookings});
      });
    });
  }

}
