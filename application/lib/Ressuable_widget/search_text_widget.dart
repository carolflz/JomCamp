import 'package:flutter/material.dart';

class SearchText extends StatefulWidget {
  const SearchText({super.key});

  @override
  State<SearchText> createState() => _SearchTextState();
}

class _SearchTextState extends State<SearchText> {
  final campsiteList = [
    "Campsite 1",
    "Campsite 2",
    "Campsite 3",
  ];

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
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return List<ListTile>.generate(
          campsiteList.length,
          (int index) => ListTile(
            title: Text(campsiteList[index]),
            onTap: () {
              controller.text = campsiteList[index];
              controller.closeView(campsiteList[index]);
            },
          ),
        );
      }
    );
  }
}