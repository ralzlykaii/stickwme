import 'package:flutter/material.dart';
import 'package:stickwmeapp/screens/homescreen.dart';
import 'package:stickwmeapp/screens/registration.dart';
import 'package:stickwmeapp/screens/sign_in.dart';

class WelcomeButtons extends StatelessWidget {
  const WelcomeButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCircularButton("Sign In", Color.fromARGB(255, 52, 111, 159), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignIn()), //navigate to sign in page
          );
        }),
        SizedBox(height: 10.0), //adjust the space between buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCircularButton("Sign Up", Color.fromARGB(255, 99, 71, 124), () {
              Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Registration()), //navigate to registration page
          );
          }),
            _buildCircularButton(" Guest ", const Color.fromARGB(255, 127, 158, 92), () {
              Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()), //navigate to home page
          );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildCircularButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(27.0), 
        primary: color,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 50.0,
          fontFamily: 'BetterTogether',
          fontWeight: FontWeight.w600,
          color: Colors.black, 
        ),
      ),
    );
  }
}
