import 'package:application/Models/constant.dart';
import 'package:application/Ressuable_widget/textinput.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class TProfileMenu extends StatelessWidget {
  const TProfileMenu(
      {super.key,
      this.icon = Icons.arrow_forward_ios,
      required this.onPressed,
      required this.title,
      required this.value});

  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
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
            IconButton(
                onPressed: () {
                  var _title;
                  TextEditingController _textController =
                      TextEditingController();
                  String _selected = '';
                  if (title == "Name" || title == "Username") {
                    _title = TextInput(
                      title: title,
                      controller: _textController,
                      icon: LineAwesomeIcons.user,
                    );
                  } else if (title == "E-mail") {
                    _title = TextInput(
                      title: title,
                      controller: _textController,
                      icon: LineAwesomeIcons.mail_bulk,
                    );
                  } else if (title == "Phone Number") {
                    _title = TextInput(
                      title: title,
                      controller: _textController,
                      icon: LineAwesomeIcons.phone,
                    );
                  } else if (title == "Gender") {
                    _title = DropdownButtonFormField(
                      decoration: InputDecoration(
                          label: Text('Level'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          floatingLabelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(width: 2)),
                          prefixIcon: Icon(LineAwesomeIcons.male)),
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.deepPurple,
                      ),
                      items: ["Male", "Female"]
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (val) {
                        _selected = val.toString();
                      },
                    );
                  } else if (title == "Date of Birth") {
                    _title = TextInput(
                      title: title,
                      controller: _textController,
                      icon: LineAwesomeIcons.calendar,
                    );
                  }

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: _title,
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                            TextButton(
                              child: Text('Edit'),
                              onPressed: () async {
                                final user = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userId);
                                // Check if the comment is not empty
                                if (_textController.text.trim().isNotEmpty) {
                                  switch (title) {
                                    case 'Name':
                                      user.update({
                                        'Name': _textController.text,
                                      });
                                      // Clear the text field and close the dialog
                                      _textController.clear();
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('User Profile Updated')),
                                      ); // Close the dialog
                                      return;
                                    case 'Username':
                                      user.update({
                                        'Username': _textController.text,
                                      });
                                      // Clear the text field and close the dialog
                                      _textController.clear();
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('User Profile Updated')),
                                      ); // Close the dialog
                                      return;
                                    case 'E-mail':
                                      user.update({
                                        'Email': _textController.text,
                                      });
                                      // Clear the text field and close the dialog
                                      _textController.clear();
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('User Profile Updated')),
                                      ); // Close the dialog
                                      return;
                                    case 'Phone Number':
                                      user.update({
                                        'Phone Number': _textController.text,
                                      });
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('User Profile Updated')),
                                      ); // Close the dialog
                                      return;
                                    case 'Date of Birth':
                                      user.update({
                                        'Birth-date': _textController.text,
                                      });
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('User Profile Updated')),
                                      ); // Close the dialog
                                      return;
                                  }
                                } else if (_selected.isNotEmpty) {
                                  user.update({
                                    'Gender': _selected,
                                  });
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('User Profile Updated')),
                                  ); // Close the dialog
                                  return;
                                } else {
                                  // If the comment is empty, show a snackbar with a message to enter a comment
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Please enter a comment')),
                                  );
                                }
                              },
                            ),
                          ],
                        );
                      });
                },
                icon: Icon(
                  icon,
                  size: 18,
                ))
          ],
        ),
      ),
    );
  }
}
