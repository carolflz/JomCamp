import 'package:flutter/material.dart';

class DisplayDetails extends StatelessWidget {
  const DisplayDetails({super.key, required this.title, required this.value});
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                )),
            Expanded(
                flex: 5,
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                )),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
