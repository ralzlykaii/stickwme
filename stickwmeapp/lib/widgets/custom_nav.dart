import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onTabChange;

  CustomNavBar({
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 170, 100, 183),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
          backgroundColor: Color.fromARGB(255, 170, 100, 183),
          color: Colors.white, // all other tab color
          activeColor: Colors.black, //selected tab color
          tabBackgroundColor: Color.fromARGB(255, 213, 203, 232), //tab background color when selected
          duration: Duration(milliseconds: 500),
          curve: Curves.ease, // tab animation curves
          gap: 8,
          onTabChange: onTabChange,
          padding: EdgeInsets.all(16),
          selectedIndex: selectedIndex,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.people,
              text: 'Friends',
            ),
            GButton(
              icon: Icons.account_circle_rounded,
              text: 'Profile',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
            )
          ],
        ),
      ),
    );
  }
}
