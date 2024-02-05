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
  Map<String, dynamic> _userData = {};
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
      _userData = userData.data() ?? {};
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
              child: ClipOval(
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: Image.network(
                    _userData['imageUrl'] ?? 'https://w1.pngwing.com/pngs/132/484/png-transparent-circle-silhouette-avatar-user-upload-pixel-art-user-profile-document-black.png',
                    fit: BoxFit.fill,
                  ),
                ),
              )
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