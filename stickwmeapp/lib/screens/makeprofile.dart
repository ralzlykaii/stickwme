import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stickwmeapp/widgets/custom_scaffold.dart';

class MakeProfile extends StatefulWidget {
  @override
  _MakeProfileState createState() => _MakeProfileState();
}

class _MakeProfileState extends State<MakeProfile> {
  File? _image;
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();

  Future getImage() async {
    final picker = ImagePicker(); // get image from device gallery 
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
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
              children: [
                GestureDetector(
                  onTap: getImage,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
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
                      Positioned(
                        bottom: 0,
                        child: _image == null 
                        ? Text(
                          'Add photo',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontFamily: 'BetterTogether',
                            fontWeight: FontWeight.w400,
                            ),
                        ) 
                        : Container(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                buildTextBox('First Name', 'BetterTogether', 0xFFDECADF, controller: _firstNameController),
                SizedBox(height: 20),
                buildTextBox('Last Name', 'BetterTogether', 0xFFDECADF, controller: _lastNameController),
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
}