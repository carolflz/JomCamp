import 'package:application/Ressuable_widget/profile_menu.dart';
import 'package:application/Ressuable_widget/section_heading.dart';
import 'package:application/api/notification_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  final String userID;
  const ProfileScreen({super.key, required this.userID});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(id: userID);
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  _ProfileScreenState({required this.id});
  final double coverHeight = 280;
  final double profileHeight = 144;
  double value = 3.5;
  String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
          // TextButton(
          //   onPressed: createCampsiteAlertNotification,
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Icon(
          //         Icons.notification_add,
          //         color: Colors.blue, // You can set the color you prefer
          //       ),
          //       SizedBox(
          //           width: 8.0), // Add some spacing between the icon and text
          //       Text(
          //         'Create Campsite Alert Notification',
          //         style: TextStyle(
          //           color: Colors.blue, // You can set the color you prefer
          //           fontWeight: FontWeight
          //               .bold, // You can set the font weight you prefer
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  Widget buildTop() {
    final double bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;

    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: bottom),
              child: buildCoverImage()),
          Positioned(top: top, child: buildProfileImage()),
        ]);
  }

  Widget buildContent() => StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('users').doc(id).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        var output = snapshot.data!.data() as Map<String, dynamic>;
        String name = output["Name"];
        String username = output["Username"];
        String state = output["State"];
        String email = output["Email"];
        String phone_num = output["Phone Number"];
        String gender = output["Gender"];
        String birthDate = output["Birth-date"];

        return Column(children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 2,
          ),
          Text('$state, Malaysia',
              style: TextStyle(fontSize: 16, color: Colors.black38)),
          const SizedBox(
            height: 16,
          ),
          Divider(),
          TSectionHeading(
            title: 'Profile Information',
            showActionButton: false,
          ),
          const SizedBox(
            height: 5,
          ),
          TProfileMenu(onPressed: () {}, title: 'Name', value: name),
          const SizedBox(
            height: 8,
          ),
          TProfileMenu(onPressed: () {}, title: 'Username', value: username),
          Divider(),
          TSectionHeading(
            title: 'Personal Information',
            showActionButton: false,
          ),
          const SizedBox(
            height: 8,
          ),
          TProfileMenu(onPressed: () {}, title: 'E-mail', value: email),
          const SizedBox(
            height: 8,
          ),
          TProfileMenu(
              onPressed: () {}, title: 'Phone Number', value: phone_num),
          const SizedBox(
            height: 8,
          ),
          TProfileMenu(onPressed: () {}, title: 'Gender', value: gender),
          const SizedBox(
            height: 8,
          ),
          TProfileMenu(
              onPressed: () {}, title: 'Date of Birth', value: birthDate),
        ]);
      });

  Widget buildCoverImage() => Container(
      color: Colors.grey,
      child: Image.network(
          'https://wallpapers.com/images/high/profile-picture-background-10tprnkqwqif4lyv.webp',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover));

  Widget buildProfileImage() => CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: NetworkImage(
          'https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg'));
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
