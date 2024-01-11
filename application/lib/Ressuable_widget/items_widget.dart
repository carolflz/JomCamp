import 'package:flutter/material.dart';
import 'package:application/screen/item_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsWidget extends StatelessWidget {
  final String category;

  ItemsWidget({required this.category});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('equipments').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        var items = snapshot.data!.docs;

        return GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          shrinkWrap: true,
          childAspectRatio: (160 / 210),
          children: [
            for (var item in items)
              if (item['Type'] == category) ItemWidget(item: item, category: category),
          ],
        );
      },
    );
  }
}

class ItemWidget extends StatelessWidget {
  final DocumentSnapshot<Object?> item;
  final String category;

  ItemWidget({required this.item, required this.category});

  @override
  Widget build(BuildContext context) {
    String title = item['Item Name'];
    String condition = item['Condition'];
    int price = (item['Rental Price'] as int);
    String imageUrl = item['Image'];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => ItemDetailsScreen(
                    item: item,
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0), 
              child: Container(
                width: 140,
                height: 100,
                child: Image.network(
                  imageUrl, 
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "$condition",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "RM $price",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
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
