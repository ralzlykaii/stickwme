import 'package:flutter/material.dart';
import 'package:stickwmeapp/screens/homescreen.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
              buildTextBox('Email', 'BetterTogether', 0xFFDECADF, controller: _emailController),

              SizedBox(height: 16.0), //adjust the space between email and password fields

              //password textbox
              buildTextBox('Password', 'BetterTogether', 0xFFDECADF, isPassword: true, controller: _passwordController),

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
                  signIn(); //call sign in function
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

  Widget buildTextBox(String label, String fontFamily, int borderColor, {bool isPassword = false, TextEditingController? controller}) {
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

  Future<void> signIn() async {
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

      if (password.isEmpty) {
        //show a message if password is empty
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Passwords is empty.'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      try{
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      print('User signed in: ${userCredential.user?.uid}');

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login error. Try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  } 
}