import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stickwmeapp/widgets/custom_nav.dart';
import 'package:stickwmeapp/widgets/custom_scaffold.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _noteController = TextEditingController();
  List<String> _notes = [];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImageOpacity: 0.4,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _notes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: _generateRandomColor(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          title: Text(
                            _notes[index],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _addNote(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(30.0),
                ),
                child: Text(
                  'Add a note',
                  style: TextStyle(
                    fontSize: 37.0,
                    fontFamily: 'BetterTogether',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomNavBar(
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a Note'),
          content: TextField(
            controller: _noteController,
            decoration: InputDecoration(hintText: 'Enter your note'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _saveNote(); //saves not
                Navigator.pop(context); //close and save
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); //close dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  //add notes to list
  void _saveNote() {
    String note = _noteController.text;

    _saveNotetoDB(note);

    setState(() {
      _notes.add(note);
    });
    //do more here
    //save note to user data in firebase
  }

  Color _generateRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
  
 void _saveNotetoDB(String note) async {
    try {
      User? user = FirebaseAuth.instance.currentUser; //get the current user

      if (user != null) {
        String userId = user.uid; //extract userid

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('stickynotes')
            .add({
          'note': note,
          'creation_date': FieldValue.serverTimestamp(),
        });
      } else {
        print('No user signed in');
      }
    } catch (e) {
      print('Error saving note: $e');
    }
  }
}