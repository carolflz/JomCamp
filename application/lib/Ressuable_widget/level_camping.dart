import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'campsite_details_test.dart';

class LevelState extends StatefulWidget {
  @override
  State<LevelState> createState() => LevelText();
}

class LevelText extends State<LevelState> {
  final Map<String, Color> levelColors = {
    'Beginner': Color(0xFF073B3A),
    'Intermediate': Color(0xFF073B3A),
    'Advanced': Color(0xFF073B3A),
  };

  final List<String> _levelLabels = [
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  List<String> id = [];
  Future<List<Map<String, dynamic>>> getData(level) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    id = [];
    return await db.collection("google_map_campsites").get().then(
      (querySnapshot) {
        List<Map<String, dynamic>> dataFromFirestore = [];
        print("Successfully completed");
        for (var doc in querySnapshot.docs) {
          if (doc.data()["Level"] == level) {
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
            'Levels',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Container(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _levelLabels.length,
                    itemBuilder: (context, index) {
                      final level = _levelLabels[index];
                      final color =
                          levelColors[level] ?? Colors.grey; // Default color if not found

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 1.0, 10.0, 0),
                        child: ActionChip(
                          backgroundColor: color,
                          onPressed: () {
                            getData(level).then((value) {
                              setState(() {
                                dataFetched = value;
                              });
                            });
                          },
                          label: Center(
                            child: Text(
                              level,
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
                                  dataFetched[index],
                                  id[index],
                                ),
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
