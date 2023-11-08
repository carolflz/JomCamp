import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app/screens/signin_screen.dart';
import 'package:mobile_app/utils/color_utils.dart';

import '../reusable_widgets/reusable_widgets.dart';

import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text( 
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )
        ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:
           [hexStringToColor("CD2B93"),  
            hexStringToColor("9546C4"), 
            hexStringToColor("5E61f4")
            ], 
          begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: SingleChildScrollView(
                child: Padding(padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height*0.2, 20, 0),
                child: Column(
                    children: <Widget>[  

                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Username", Icons.person_outlined, false, _userNameTextController),

                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Email", Icons.person_outlined, false, _emailTextController),

                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Password", Icons.lock_outlined, true, _passwordTextController),

                      const SizedBox(
                        height: 20,
                      ),
                      signInSignUpButton(context, false, (){
                        FirebaseAuth.instance
                        .createUserWithEmailAndPassword(email: _emailTextController.text, password: _passwordTextController.text)
                        .then((value) {
                          print("Created New Account");

                          Navigator
                        .push(context, MaterialPageRoute(builder: (context) => const SignInScreen())); 
                        }).onError((error, stackTrace) { print("Error: ${error.toString()}");}); 
                      })
                      
            ],
          ),
        ),
       ),
     ),
    );
  }
}