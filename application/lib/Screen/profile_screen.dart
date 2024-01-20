import 'package:application/Ressuable_widget/profile_menu.dart';
import 'package:application/Ressuable_widget/section_heading.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  final double coverHeight = 280;
  final double profileHeight = 144;
  double value = 3.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
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

  Widget buildContent() => Column(children: [
        const SizedBox(
          height: 8,
        ),
        Text(
          'James Jordan',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 2,
        ),
        Text('Penang, Malaysia',
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
        TProfileMenu(onPressed: () {}, title: 'Name', value: 'James Jordan'),
        const SizedBox(
          height: 8,
        ),
        TProfileMenu(onPressed: () {}, title: 'Username', value: 'Noodbist'),
        Divider(),
        TSectionHeading(
          title: 'Personal Information',
          showActionButton: false,
        ),
        const SizedBox(
          height: 8,
        ),
        TProfileMenu(
            onPressed: () {}, title: 'E-mail', value: 'james23@gmail.com'),
        const SizedBox(
          height: 8,
        ),
        TProfileMenu(
            onPressed: () {}, title: 'Phone Number', value: '+6012-345 6789'),
        const SizedBox(
          height: 8,
        ),
        TProfileMenu(onPressed: () {}, title: 'Gender', value: 'Male'),
        const SizedBox(
          height: 8,
        ),
        TProfileMenu(
            onPressed: () {}, title: 'Date of Birth', value: '12 Dec, 2002'),
      ]);

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
