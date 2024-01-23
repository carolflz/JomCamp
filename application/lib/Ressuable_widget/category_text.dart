import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'campsite_details_test.dart'; // Import CampsiteDetailsScreen

class CategoryText extends StatefulWidget {
  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  final Map<String, Color> categoryColor = {
    'Forested': Color.fromARGB(255, 150, 212, 78), // Light Green
    'Riverside': Color.fromRGBO(92, 182, 255, 1), // Light Blue
    'Mountainous': Color.fromARGB(255, 253, 126, 117), // Light Red
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
  List<String> id = [];
  Future<List<Map<String, dynamic>>> getData(category) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    id = [];
    return await db.collection("google_map_campsites").get().then(
      (querySnapshot) {
        List<Map<String, dynamic>> dataFromFirestore = [];
        print("Successfully completed");
        for (var doc in querySnapshot.docs) {
          if (doc.data()["Category"] == category) {
            dataFromFirestore.add(doc.data());
            id.add(doc.id);
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
            margin: EdgeInsets.only(
                top: 10), // Add margin to move the category labels down
            height: 50, // Increase the height of the category label box
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
                                fontSize: 18, // Adjust the text size
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
              : ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: dataFetched.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(dataFetched[index]["Name"]),
                        leading: Image.network(dataFetched[index]["image"]),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CampsiteDetailsScreen(
                                    dataFetched[index], id[index]),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.green, // Text color
                          ),
                          child: Text('View Details'),
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
