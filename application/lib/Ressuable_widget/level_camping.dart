import 'package:flutter/material.dart';

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
                          onPressed: () {},
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
}
