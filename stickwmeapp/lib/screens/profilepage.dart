import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stickwmeapp/widgets/custom_nav.dart';
import 'package:stickwmeapp/widgets/custom_scaffold.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User _user;
  late Map<String, dynamic> _userData;
  File? _image;
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .get();

    setState(() {
      _userData = userData.data()!;
      String imageUrl = _userData['imageUrl'] ?? '';
      if (imageUrl.isNotEmpty) {
        _image = File(imageUrl);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (_selectedIndex) {
            case 0:
              Navigator.pushNamed(context, 'homescreen');
              break;
            case 1:
              //Navigator.pushNamed(context, 'friendspage');
              break;
            case 2:
              Navigator.pushNamed(context, 'profilepage');
              break;
            case 3:
            //Navigator.pushNamed(context, 'settings');
            break;
          }
        },
      ),
      backgroundImageOpacity: 0.7,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey[300],
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Colors.grey[600],
                      )
                    : null,
            ),
            SizedBox(height: 5),
            Text(
              _user.email ?? 'Email',
              style: TextStyle(
                fontSize: 18,
                ),
            ),
            SizedBox(height: 10),
            Text(
              "${_userData['firstName']} ${_userData['flastName']}" ?? 'Name',
              style: TextStyle(
                fontSize: 57,
                fontWeight: FontWeight.w600,
                fontFamily: 'BetterTogether',
                ),
            ),
          ],
        ),
      ),
    );
  }
}