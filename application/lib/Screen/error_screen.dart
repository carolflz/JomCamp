import 'package:application/main.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/Location_Error.jpg",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 13),
                    blurRadius: 25,
                    color: Color(0xFFD27E4A).withOpacity(0.17),
                  ),
                ],
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
                    '/',
                    (route) => (route.settings.name != '/') || route.isFirst,
                  );
                },
                child: Text(
                  "Okay".toUpperCase(),
                  style: TextStyle(
                      color: Colors.black), // Set the text color as needed
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
