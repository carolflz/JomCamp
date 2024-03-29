// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  final List<String> _categorylable = [
    'Cat 1',
    'Cat 2',
    'Cat 3',
    'Cat 4',
    'Cat 5',
    'Cat 6',
    'Cat 7',
    'Cat 8'
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categorylable.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: ActionChip(
                                backgroundColor: Colors.yellow.shade900,
                                onPressed: () {},
                                label: Center(
                                  child: Text(_categorylable[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      )),
                                )),
                          );
                        })),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
