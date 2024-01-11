import 'package:flutter/material.dart';
import 'package:stickwmeapp/widgets/custom_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _rememberMe = false;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 117.0, left: 37.0, bottom: 37.0, right: 37.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //emailtextbox
              buildTextBox('Email', 'BetterTogether', 0xFFDECADF),

              SizedBox(height: 16.0), //adjust the space between email and password fields

              //password textbox
              buildTextBox('Password', 'BetterTogether', 0xFFDECADF, isPassword: true),

              SizedBox(height: 16.0), //adjust the space between password and remember me checkbox

              //remember me Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value!;
                      });
                    },
                  ),
                  Text('Remember Me',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'BetterTogether',
                    fontWeight: FontWeight.w500,
                    ),
                    ),
                ],
              ),
              SizedBox(height: 16.0), //adjust the space between remember me checkbox and login button

              //login Button
              ElevatedButton(
                onPressed: () {
                  // Implement your login logic here
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(37.0),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontFamily: 'BetterTogether',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextBox(String label, String fontFamily, int borderColor, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword && !_showPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 43.0,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(borderColor),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}