import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LevelState extends StatefulWidget {
  @override
  State<LevelState> createState() => LevelText();
}

class LevelText extends State<LevelState> {
  final Map<String, Color> levelColors = {
    'Beginner': Colors.green.shade300,
    'Intermediate': Colors.amber.shade300,
    'Advanced': Colors.deepOrange.shade300,
  };

  final List<String> _levelLabels = [
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  Future<List<Map<String, dynamic>>> getData(level) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    return await db.collection("google_map_campsites").get().then(
      (querySnapshot) {
        List<Map<String, dynamic>> dataFromFirestore = [];
        print("Successfully completed");
        for (var doc in querySnapshot.docs) {
          if (doc.data()["Level"] == level) {
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
            'Levels',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Container(
            height: 40,
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
                          builder: (context) => CampsiteDetailsScreen(dataFetched[index]),
                              ),
                            );
                          },
                        style:ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Background color
                        foregroundColor: Colors.black, // Text color
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
