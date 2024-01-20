import 'package:flutter/material.dart';

class ComunityScreen extends StatefulWidget {
  @override
  _ComunityScreenState createState() => _ComunityScreenState();
}

class _ComunityScreenState extends State<ComunityScreen> {
  List<String> posts =
      List.generate(10, (index) => 'Here is post number $index');

  void _addNewPost() {
    setState(() {
      posts.insert(0, 'New Post at ${DateTime.now()}');
    });
  }

  void _likePost(int index) {
    // Placeholder function for liking a tweet
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Liked Post $index')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Post UI'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addNewPost,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('${index + 1}'),
              ),
              title: Text('User $index'),
              subtitle: Text(posts[index]),
              trailing: IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () => _likePost(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
