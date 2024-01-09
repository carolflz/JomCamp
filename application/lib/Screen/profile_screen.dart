import 'package:application/Ressuable_widget/number_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  final double coverHeight = 280;
  final double profileHeight = 144;
  TabController? _tabController;
  var listImage = [];
  List<double> ratings = [0.1, 0.3, 0.5, 0.7, 0.9];
  double value = 3.5;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

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
        const SizedBox(
          height: 16,
        ),
        NumbersWidget(),
        const SizedBox(
          height: 16,
        ),
        Divider(),
        Container(
          child: Align(
            alignment: Alignment.center,
            child: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicator: CircleTabIndicator(color: Colors.black, radius: 4),
                tabs: [
                  Tab(
                    text: 'Feed',
                  ),
                  Tab(
                    text: 'Photo',
                  ),
                  Tab(
                    text: 'Review',
                  ),
                ]),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          width: double.maxFinite,
          height: 300,
          child: TabBarView(controller: _tabController, children: [
            Center(child: Text("You don't have any Feed")),
            Center(child: Text("You don't have any Pictures")),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "4.5",
                            style: TextStyle(fontSize: 48.0),
                          ),
                          TextSpan(
                            text: "/5",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RatingStars(
                      value: value,
                      onValueChanged: (v) {
                        setState(() {
                          value = v;
                        });
                      },
                      starCount: 5,
                      starSize: 20,
                      valueLabelColor: const Color(0xff9b9b9b),
                      valueLabelTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.0),
                      valueLabelRadius: 10,
                      maxValue: 5,
                      starSpacing: 2,
                      maxValueVisibility: true,
                      valueLabelVisibility: true,
                      animationDuration: Duration(milliseconds: 1000),
                      valueLabelPadding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 8),
                      valueLabelMargin: const EdgeInsets.only(right: 8),
                      starOffColor: const Color(0xffe7e8ea),
                      starColor: Colors.yellow,
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
                Container(
                  width: 200.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text(
                            "${index + 1}",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(height: 4.0),
                          Icon(Icons.star, color: Colors.orange),
                          SizedBox(height: 8.0),
                          LinearPercentIndicator(
                            lineHeight: 6.0,
                            // linearStrokeCap: LinearStrokeCap.roundAll,
                            width: MediaQuery.of(context).size.width / 2.8,
                            animation: true,
                            animationDuration: 2500,
                            percent: ratings[index],
                            progressColor: Colors.orange,
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ]),
        ),
        const SizedBox(
          height: 32,
        )
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
