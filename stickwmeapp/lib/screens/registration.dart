import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:stickwmeapp/screens/makeprofile.dart';
import 'package:stickwmeapp/widgets/custom_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool _showPassword = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 127.0, left: 37.0, bottom: 37.0, right: 37.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //email textbox
              buildTextBox('Email', 'BetterTogether', 0xFFDECADF, controller: _emailController),

              SizedBox(height: 16.0), //adjust the space between email and password fields

              //password textbox
              buildTextBox('Password', 'BetterTogether', 0xFFDECADF, isPassword: true, controller: _passwordController),

              SizedBox(height: 16.0), //adjust the space between

              //confirm password textbox
              buildTextBox('Confirm Password', 'BetterTogether', 0xFFDECADF, isPassword: true, controller: _confirmPasswordController),

              SizedBox(height: 16.0), //adjust the space between

              // register button
              ElevatedButton(
                onPressed: () {
                  _register();
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(37.0),
                ),
                child: Text(
                  'Register',
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

  Widget buildTextBox(String label, String fontFamily, int borderColor,
      {bool isPassword = false, TextEditingController? controller}) {
    return TextField(
      obscureText: isPassword && !_showPassword,
      controller: controller,
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

  Future<void> _register() async {
    try {
      //trim and validate email
      final String email = _emailController.text.trim();
      if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email cannot be empty.'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      //trim and validate passwords
      final String password = _passwordController.text.trim();
      final String confirmPassword = _confirmPasswordController.text.trim();

      if (password.isEmpty || confirmPassword.isEmpty || password != confirmPassword) {
        //show a message or handle the case of mismatched or empty passwords
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Passwords do not match or are empty.'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }
  
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //add the user to database
      //addUserData(_emailController.text.trim());

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MakeProfile(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      //show a SnackBar for specific registration failure scenarios
      String errorMessage = 'Registration failed';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      //show a SnackBar for other registration failure scenarios
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  //Future addUserData(String email) async{
  //  await FirebaseFirestore.instance.collection('users').add({
  //    'email': email,
  //  });
  //}

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
