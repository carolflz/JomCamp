import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
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

  void _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  void _savePostToFirestore() async {
    if (_imageFile != null) {
      // Generate a unique file name for the uploaded image
      String fileName = path.basename(_imageFile!.path);
      String uniqueFileName =
          '${DateTime.now().millisecondsSinceEpoch}_$fileName';

      try {
        // Upload the image to Firebase Storage
        final firebase_storage.Reference storageRef = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('images/$uniqueFileName');
        await storageRef.putFile(File(_imageFile!.path));

        // Get the download URL of the uploaded image
        String downloadURL = await storageRef.getDownloadURL();

        // Get the current timestamp
        Timestamp timestamp = Timestamp.now();

        // Prepare the post data
        Map<String, dynamic> postData = {
          'imageCaption': _captionController.text,
          'imageTitle': _titleController.text,
          'imagePath': downloadURL, // Set the download URL as the image path
          'userId': '4MqqYhtK4bvMWliLJXJc', // Replace with the actual user ID
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
        title: Text('Add New Post'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
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
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Add a Title',
                ),
              ),
              TextFormField(
                controller: _captionController,
                decoration: InputDecoration(
                  labelText: 'Add a caption',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
