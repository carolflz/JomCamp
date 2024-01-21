import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryText extends StatefulWidget {
  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  final Map<String, Color> categoryColor = {
    'Forested': Color.fromARGB(255, 150, 212, 78),   // Light Green
    'Riverside': Color.fromRGBO(92, 182, 255, 1),  // Light Blue
    'Mountainous': Color.fromARGB(255, 253, 126, 117),// Light Red
    'Family-friendly': Color.fromARGB(255, 236, 96, 143), // Light Pink
    'Sunset-view': Color.fromARGB(255, 250, 196, 81), // Light Orange
  };

  final List<String> _categoryLabels = [
    'Forested',
    'Riverside',
    'Mountainous',
    'Family-friendly',
    'Sunset-view',
  ];

  Future<List<Map<String, dynamic>>> getData(category) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    return await db.collection("google_map_campsites").get().then(
      (querySnapshot) {
        List<Map<String, dynamic>> dataFromFirestore = [];
        print("Successfully completed");
        for (var doc in querySnapshot.docs) {
          if (doc.data()["Category"] == category) {
            dataFromFirestore.add(doc.data());
          }
        }
        print("Returning data");
        return dataFromFirestore;
      },
      onError: (e) {
        print("Error: $e");
        return null;
      },
    );
  }

  var dataFetched;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 6.0, 9.0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Container(
            height: 35,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categoryLabels.length,
                    itemBuilder: (context, index) {
                      final category = _categoryLabels[index];
                      final color = categoryColor[category] ?? Colors.grey;

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 1.0, 10.0, 0),
                        child: ActionChip(
                          backgroundColor: color,
                          onPressed: () {
                            getData(category).then((value) {
                              setState(() {
                                dataFetched = value;
                              });
                            });
                          },
                          label: Center(
                            child: Text(
                              category,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          dataFetched == null
              ? Container()
              : SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: dataFetched.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(dataFetched[index]["Name"]),
                              leading: Image.network(dataFetched[index]["image"]),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CampsiteDetailsScreen(dataFetched[index]),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue, // Background color
                              onPrimary: Colors.black, // Text color
                            ),
                            child: Text('View details'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class CampsiteDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> campsiteData;

  CampsiteDetailsScreen(this.campsiteData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campsite Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${campsiteData["Name"]}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Image: ${campsiteData["image"]}',
              style: TextStyle(fontSize: 16),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
