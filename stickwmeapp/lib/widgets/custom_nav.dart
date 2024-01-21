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
    return GNav(
      rippleColor: Color.fromARGB(255, 162, 134, 228), // tab button ripple color when pressed
      hoverColor: Colors.grey, // tab button hover color
      haptic: true, // haptic feedback
      tabBorderRadius: 15,
      tabActiveBorder: Border.all(color: Colors.black, width: 1), // tab button border
      tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
      tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
      curve: Curves.easeOutExpo, // tab animation curves
      duration: Duration(milliseconds: 500), // tab animation duration
      gap: 8, // the tab button gap between icon and text 
      color: Colors.grey[800], // unselected icon color
      activeColor: Colors.purple, // selected icon and text color
      iconSize: 24, // tab button icon size
      tabBackgroundColor: Colors.purple.withOpacity(0.1), // selected tab background color
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5), // navigation bar padding
      tabs: [
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
      selectedIndex: selectedIndex,
      onTabChange: onTabChange,
    );
  }
}
