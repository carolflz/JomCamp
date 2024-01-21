import 'package:flutter/material.dart';

class CampsiteDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> campsiteData;

  CampsiteDetailsScreen(this.campsiteData);

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
                    campsiteData["Name"],
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
                      buildTag('Category', campsiteData["Category"]),
                      SizedBox(height: 8),
                      buildTag('Level', campsiteData["Level"]),
                      SizedBox(height: 8),
                      buildUnderlinedText('Address', campsiteData["Address"]),
                      SizedBox(height: 8),
                      buildUnderlinedText('Description', campsiteData["Description"]),
                      SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle booking logic here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 3, 61, 5), // Dark Green
                            minimumSize: Size(200, 50), // Adjust button size
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Book this campsite',
                              style: TextStyle(fontSize: 18, color: Colors.white),
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
        'Forested': Color.fromARGB(255, 150, 212, 78),
        'Riverside': Color.fromRGBO(92, 182, 255, 1),
        'Mountainous': Color.fromARGB(255, 253, 126, 117),
        'Family-friendly': Color.fromARGB(255, 236, 96, 143),
        'Sunset-view': Color.fromARGB(255, 250, 196, 81),
      },
      'Level': {
        'Beginner': Colors.green.shade300,
        'Intermediate': Colors.amber.shade300,
        'Advanced': Colors.deepOrange.shade300,
      },
    };

    final Color tagColor = tagColors[label]?[value ?? ''] ?? Colors.grey;

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
          style: TextStyle(fontSize: 16, decoration: TextDecoration.underline),
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
