import 'package:application/Screen/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CampsiteDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> campsiteData;
  final String id;

  CampsiteDetailsScreen(this.campsiteData, this.id);

  @override
  _CampsiteDetailsScreenState createState() => _CampsiteDetailsScreenState();
}

class _CampsiteDetailsScreenState extends State<CampsiteDetailsScreen> {
  ScrollController _scrollController = ScrollController();
  bool isNameWhite = true;
  String status = 'Unpaid';

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      setState(() {
        // Check if the scroll offset is greater than a certain value (adjust as needed)
        isNameWhite = _scrollController.offset < 200;
      });
    });
  }

  // Function to handle the Google Maps navigation
  void navigateToGoogleMaps() async {
    // Extract GeoPoint from campsiteData
    GeoPoint geoPoint = widget.campsiteData['LatLng'];

    // Check if GeoPoint is not null
    if (geoPoint != null) {
      double latitude = geoPoint.latitude ?? 0.0;
      double longitude = geoPoint.longitude ?? 0.0;

      // Open Google Maps with the specified LatLng
      String googleMapsUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      if (await canLaunch(googleMapsUrl)) {
        await launch(googleMapsUrl);
      } else {
        // Handle if Google Maps app is not installed
        print('Could not open Google Maps');
      }
    } else {
      // Handle case when LatLng is null or not a GeoPoint
      print('LatLng is null or not a GeoPoint');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: isNameWhite ? Colors.white : Colors.black,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.campsiteData['Name'],
                    style: TextStyle(
                      color: isNameWhite ? Colors.white : Colors.black,
                      fontSize: 18,
                      shadows: [
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              background: Image.network(
                widget.campsiteData["image"],
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTag('Category', widget.campsiteData["Category"]),
                          SizedBox(height: 5),
                          buildTag('Level', widget.campsiteData["Level"]),
                          SizedBox(height: 24),
                        ],
                      ),
                      buildUnderlinedText('Campsite Fee', 'RM${widget.campsiteData["Fee"].toStringAsFixed(2)}'),
                      SizedBox(height: 22),
                      buildUnderlinedText('Address', widget.campsiteData["Address"]),
                      SizedBox(height: 22),
                      buildUnderlinedText(
                          'Description', widget.campsiteData["Description"]),
                      SizedBox(height: 36),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                           DocumentReference bookingRef = FirebaseFirestore.instance.collection('Booking').doc();
                            await bookingRef.set({
                              'Campsite Id': widget.id,
                              'User Id': "82if9IwGprY5177fv80m",
                              'Status': status,
                            });

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BookingScreen(bookingRef.id),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color.fromARGB(255, 3, 61, 5), 
                            minimumSize: Size(200, 50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Book this campsite',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16), // Add space between the buttons
                      Center(
                        child: ElevatedButton(
                          onPressed: navigateToGoogleMaps,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF3D251E), // Button color #3D251E
                            minimumSize: Size(200, 50), // Adjust button size
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Navigate to Campsite',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTag(String label, String? value) {
    final Map<String, Map<String, Color>> tagColors = {
      'Category': {
        'Forested': Color(0xFF043927),
        'Riverside': Color(0xFF043927),
        'Mountainous': Color(0xFF043927),
        'Family-friendly': Color(0xFF043927),
        'Sunset-view': Color(0xFF043927),
      },
      'Level': {
        'Beginner': Color(0xFF073B3A),
        'Intermediate': Color(0xFF073B3A),
        'Advanced': Color(0xFF073B3A),
      },
    };

    final Color tagColor = tagColors[label]?[value ?? ''] ?? Color(0xFF073B3A);

    return Chip(
      backgroundColor: tagColor,
      label: Text(
        '$label: $value',
        style: TextStyle(
          fontSize: 16,
          color: tagColor == Colors.amber.shade300 ? Colors.black : Colors.white,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    );
  }

  Widget buildUnderlinedText(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label',
          style: TextStyle(
              fontSize: 20,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          '$value',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}