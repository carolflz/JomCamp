import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  final Map<String, Color> categoryColor = {
    'Forested': Color.fromARGB(255, 150, 212, 78),   // Light Green
    'Riverside': Color.fromRGBO(92, 182, 255, 1),  // Light Blue
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
                      final color = categoryColor[category] ?? Colors.grey; // Default color if not found

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 1.0, 10.0, 0),
                        child: ActionChip(
                          backgroundColor: color,
                          onPressed: () {},
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
        ],
      ),
    );
  }
}
