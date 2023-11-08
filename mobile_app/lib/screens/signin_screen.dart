import 'package:mobile_app/screens/signup_screen.dart';
import 'package:mobile_app/utils/color_utils.dart';

import '../reusable_widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
 final TextEditingController _passwordTextController = TextEditingController();
 final TextEditingController _emailTextController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
                        logoWidget("assets/images/logo_sigin.png"), 
                        const SizedBox(
                          height: 30,
                        ),
                        reusableTextField("Enter Username", Icons.person_outlined, false, _emailTextController),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextField("Enter Password", Icons.lock_outlined, false, _passwordTextController),
                         const SizedBox(
                          height: 20,
                        ),
                        signInSignUpButton(context, true, () {}),
                        signUpOption()
                    ],
          ),
        ),
       ),
     ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
        style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: (){
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        )
      ],
    );
  }
}