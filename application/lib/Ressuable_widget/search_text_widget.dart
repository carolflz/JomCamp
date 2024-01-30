import 'package:application/Ressuable_widget/campsite_details_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchText extends StatefulWidget {
  const SearchText({super.key});

  @override
  State<SearchText> createState() => _SearchTextState();
}

class _SearchTextState extends State<SearchText> {
  List<Map<String, dynamic>> campsiteList = [];
  List<String> id = [];
  // reads data from firestore
  Future<List<Map<String, dynamic>>> getData() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return await db.collection("google_map_campsites").get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var doc in querySnapshot.docs) {
          campsiteList.add(doc.data());
          id.add(doc.id);
        }
        return campsiteList;
      },
      onError: (e) {
        print("Error: $e");
        return null;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
      return SearchBar(
        controller: controller,
        leading: const Icon(Icons.search),
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD2B48C)),
        hintText: 'Search For Campsite',
        onTap: () => controller.openView(),
        onChanged: (value) => controller.openView(),
      );
    }, suggestionsBuilder: (BuildContext context, SearchController controller) {
      return List<ListTile>.generate(
        campsiteList.length,
        (int index) => ListTile(
          title: Text(campsiteList[index]["Name"]),
          onTap: () {
            controller.closeView(campsiteList[index]["Name"]);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CampsiteDetailsScreen(campsiteList[index], id[index])));
          },
        ),
      );
    });
  }
}
