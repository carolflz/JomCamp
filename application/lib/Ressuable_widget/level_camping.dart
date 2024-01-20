import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LevelText extends StatelessWidget {
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
                      final color = levelColors[level] ?? Colors.grey; // Default color if not found

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 1.0, 10.0, 0),
                        child: ActionChip(
                          backgroundColor: color,
                          onPressed: () {
                            // Call a function to fetch data based on the selected level
                            fetchDataFromFirestore(level);
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
        ],
      ),
    );
  }

  void fetchDataFromFirestore(String selectedLevel) {
    // Access Firestore and fetch data based on the selected level
    CollectionReference campsites = FirebaseFirestore.instance.collection('campsites');

    if (selectedLevel == 'All') {
      // Fetch all campsites
      campsites.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          print(doc.data());
          // Handle each document as needed
        });
      });
    } else {
      // Fetch campsites based on the selected level
      campsites.where('Level', isEqualTo: selectedLevel).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          print(doc.data());
          // Handle each document as needed
        });
      });
    }
  }
}
