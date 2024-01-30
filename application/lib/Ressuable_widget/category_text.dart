import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'campsite_details_test.dart'; // Import CampsiteDetailsScreen

class CategoryText extends StatefulWidget {
  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  final Map<String, Color> categoryColor = {
    'Forested': Color(0xFF043927),
    'Riverside': Color(0xFF043927),
    'Mountainous': Color(0xFF043927),
    'Family-friendly': Color(0xFF043927),
    'Sunset-view': Color(0xFF043927), // #5bb450/ Light Orange
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
              top: 10,
            ),
            height: 50,
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
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          labelPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity(
                            vertical: -4,
                            horizontal: -4,
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
                    return ListTile(
                      title: Text(dataFetched[index]["Name"]),
                      leading: SizedBox(
                        width: 100.0, // Set your desired width
                        height: 56.0, // Set your desired height
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjust the corner radius if needed
                          child: Image.network(
                            dataFetched[index]["image"],
                            fit: BoxFit
                                .cover, // This ensures the image covers the box area
                          ),
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CampsiteDetailsScreen(
                                dataFetched[index],
                                id[index],
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.green,
                        ),
                        child: Text('View Details'),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
