import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stickwmeapp/widgets/custom_scaffold.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MakeProfile extends StatefulWidget {
  @override
  _MakeProfileState createState() => _MakeProfileState();
}

class _MakeProfileState extends State<MakeProfile> {
  File? _image;
  String imageUrl = '';
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();

  Future getImage() async {
    final picker = ImagePicker(); // get image from device gallery 
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); //updates selected image file
      });
    }
  }

  Future uploadPhoto() async {
    String fileName = _image!.path; //get file name 
    Reference storageRef = FirebaseStorage.instance.ref().child(fileName); //create storage location using file name 
     
    UploadTask uploadTask = storageRef.putFile(_image!); 
    await uploadTask;                                     //upload image to firebase and wait for completion

    imageUrl = await storageRef.getDownloadURL(); //obtain download url 

    setState(() {
      imageUrl = imageUrl; //update state with download url 
    });

    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImageOpacity: 0.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 127.0, left: 37.0, bottom: 37.0, right: 37.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey[300],
                  child: ClipOval(
                    child: SizedBox(
                      width: 180,
                      height: 180,
                      child: (_image != null)?Image.file(_image!, fit: BoxFit.fill)
                      :Image.network(
                        'https://w1.pngwing.com/pngs/132/484/png-transparent-circle-silhouette-avatar-user-upload-pixel-art-user-profile-document-black.png',
                        fit: BoxFit.fill,
                        )
                      ),
                    )
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    //add photo
                    getImage();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: OvalBorder(),
                    padding: EdgeInsets.all(15.0),
                  ),
                  child: Text(
                    'Add a photo',
                    style: TextStyle(
                      fontSize: 37.0,
                      fontFamily: 'BetterTogether',
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                buildTextBox('First Name', 'BetterTogether', 0xFFDECADF, controller: _firstNameController),
                SizedBox(height: 20),
                buildTextBox('Last Name', 'BetterTogether', 0xFFDECADF, controller: _lastNameController),

                SizedBox(height: 20.0),
                //button to save profile
                ElevatedButton(
                  onPressed: () {
                    saveProfile();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(37.0),
                    primary: Color.fromARGB(255, 210, 151, 166),
                  ),
                  child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 37.0,
                    fontFamily: 'BetterTogether',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextBox(String label, String fontFamily, int borderColor,
      {bool isPassword = false, TextEditingController? controller}) {
    return TextField(
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
  
  void saveProfile() async {
    User? user = FirebaseAuth.instance.currentUser; //get current use
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    //get users name
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();

    //now uploads image to firebase storage and obtain a download url
    await uploadPhoto();

    //now save all user info to database
    //want to save under user collection
    await firestore.collection('users').doc(user?.uid).set(
      {
      'email': user?.email,
      'firstName': firstName,
      'flastName': lastName,
      'imageUrl': imageUrl,
      },
    );

    Navigator.pushNamed(context, 'homescreen');
  }
}