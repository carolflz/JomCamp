// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, non_constant_identifier_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickalert/quickalert.dart';
import 'package:web_admin/widget/textinput.dart';

class AddCampsiteScreen extends StatelessWidget {
  const AddCampsiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController address = TextEditingController();
    String _selectedLevel = '';
    String _selectedCategory = '';

    final level_item = ['Beginner', 'Intermediate', 'Advance'];
    final category_item = [
      'Riverside',
      'Forested',
      'Family-Friendly',
      'Sunset-view',
      'Mountainous',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Campsite'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            TextInput(title: 'Name', controller: name),
            SizedBox(
              height: 15,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                  label: Text('Level'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)),
                  floatingLabelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(width: 2)),
                  prefixIcon: Icon(LineAwesomeIcons.hiking)),
              icon: Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.deepPurple,
              ),
              items: level_item
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (val) {
                _selectedLevel = val.toString();
              },
            ),
            SizedBox(
              height: 15,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                  label: Text('Category'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)),
                  floatingLabelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(width: 2)),
                  prefixIcon: Icon(LineAwesomeIcons.hiking)),
              icon: Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.deepPurple,
              ),
              items: category_item
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (val) {
                _selectedCategory = val.toString();
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextInput(title: 'Address', controller: address),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () async {
                  final campsite = FirebaseFirestore.instance
                      .collection('google_map_campsites')
                      .doc();

                  if (name.text == "") {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.warning,
                      text: 'Please Insert Campsite Name',
                    );
                    return;
                  }
                  if (_selectedLevel == "") {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.warning,
                      text: 'Please Select Campsite Level',
                    );
                    return;
                  }
                  if (_selectedCategory == "") {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.warning,
                      text: 'Please Insert Campsite Category',
                    );
                    return;
                  }
                  if (address.text == "") {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.warning,
                      text: 'Please Insert Campsite Address',
                    );
                    return;
                  }

                  final json = {
                    'Name': name.text,
                    'Address': address.text,
                    'Level': _selectedLevel,
                    'Category': _selectedCategory,
                  };
                  await campsite.set(json);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    side: BorderSide.none,
                    shape: const StadiumBorder()),
                child: Center(
                  child: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
