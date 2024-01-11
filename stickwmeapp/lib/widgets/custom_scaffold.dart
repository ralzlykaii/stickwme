import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ), 
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset('images/appbackground.png',
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity),
          SafeArea(child: child!)
        ]
      )
    );
  }
}