import 'package:application/Screen/booking_screen.dart';
import 'package:flutter/material.dart';

class CampsiteDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> campsiteData;
  final String id;

  CampsiteDetailsScreen(this.campsiteData, this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
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
                    campsiteData['Name'],
                    style: TextStyle(
                      color: Colors.white,
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
                campsiteData["image"],
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
                  buildTag('Category', campsiteData["Category"]),
                  SizedBox(height: 5),
                  buildTag('Level', campsiteData["Level"]),
                  SizedBox(height: 24),
                  // Add more tags or information as needed
                ],
              ),
                      buildUnderlinedText('Address', campsiteData["Address"]),
                      SizedBox(height: 22),
                      buildUnderlinedText(
                          'Description', campsiteData["Description"]),
                      SizedBox(height: 36),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BookingScreen(id),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color.fromARGB(255, 3, 61, 5), // Dark Green
                            minimumSize: Size(200, 50), // Adjust button size
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
                      // Add more details as needed
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
          color:
              tagColor == Colors.amber.shade300 ? Colors.black : Colors.white,
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
