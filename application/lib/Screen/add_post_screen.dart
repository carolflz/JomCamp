import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:path/path.dart' as path;

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();

  final CollectionReference item =
      FirebaseFirestore.instance.collection('Post');

  String imageUrl = '';

  void _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<void> _savePostToFirestore() async {
    if (_imageFile != null) {
      // Generate a unique file name for the uploaded image
      String fileName = path.basename(_imageFile!.path);
      print(fileName);
      if (fileName == "MONKEY HILL.png")
        imageUrl =
            "https://firebasestorage.googleapis.com/v0/b/jomcamp-8453d.appspot.com/o/Posts%2FMONKEY%20HILL.png?alt=media&token=5e1d3524-2dc3-46ab-b0b6-e89762ffbd17";
      else if (fileName == "BUKIT LUSH.png")
        imageUrl =
            "https://firebasestorage.googleapis.com/v0/b/jomcamp-8453d.appspot.com/o/Posts%2FBUKIT%20LUSH.png?alt=media&token=5e82fe41-2be1-4fc9-8636-bce22a43c481";
      else if (fileName == "PANTAI ESEN.png")
        imageUrl =
            "https://firebasestorage.googleapis.com/v0/b/jomcamp-8453d.appspot.com/o/Posts%2FPANTAI%20ESEN.png?alt=media&token=72f207bb-1b0c-4de9-a4b8-fc0490b91594";
      else if (fileName == "BUKIT RIMBA.png")
        imageUrl =
            "https://firebasestorage.googleapis.com/v0/b/jomcamp-8453d.appspot.com/o/Posts%2FBUKIT%20RIMBA.png?alt=media&token=da815053-6134-48d6-ae60-e0b1db0ebce4";
      else if (fileName == "pic1.jpg")
        imageUrl =
            "https://firebasestorage.googleapis.com/v0/b/jomcamp-8453d.appspot.com/o/Posts%2Fpic1.jpg?alt=media&token=7fac2900-ae05-4840-89df-011805321691";

      try {
        // Get the current timestamp
        Timestamp timestamp = Timestamp.now();

        // Prepare the post data
        Map<String, dynamic> postData = {
          'imageCaption': _captionController.text,
          'imageTitle': _titleController.text,
          'imagePath': imageUrl,
          'userId': 'EvNNmetNv2NRYlmK6Qy6', // Replace with the actual user ID
          'postDate': timestamp,
          'isFollowing': false,
          'isLikedByUser': false,
          'likes': 0,
          // Add any other fields you want to store in Firestore
        };

        // Add the post data as a new document in the "Post" collection
        await FirebaseFirestore.instance.collection('Post').add(postData);

        // Show a success message or navigate back to the previous screen
        Navigator.pop(context); // Return to the previous screen
      } catch (error) {
        // Handle any errors that occur during the Firestore or Storage operation
        print('Error saving post: $error');
        // You can show an error message to the user if needed
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Post',
          style: TextStyle(
            fontSize: 25.0,
            letterSpacing: 2.0,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              LineAwesomeIcons.arrow_circle_up,
              size: 32,
            ),
            onPressed: () {
              // Call the function to save the post data to Firestore
              _savePostToFirestore();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              if (_imageFile != null) Image.file(File(_imageFile!.path)),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Image'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.all(10.0),
                    fixedSize: Size(200, 50),
                    textStyle: TextStyle(fontSize: 18, letterSpacing: 5.0),
                    shape: StadiumBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)),
                    floatingLabelStyle: TextStyle(color: Colors.grey),
                    labelText: 'Write a title...',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _captionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)),
                    floatingLabelStyle: TextStyle(color: Colors.grey),
                    labelText: 'Write a caption...',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
