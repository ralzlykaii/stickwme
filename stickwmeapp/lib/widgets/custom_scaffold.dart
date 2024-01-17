import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.child, this.backgroundImageOpacity = 0.0});
  final Widget? child;
  final double backgroundImageOpacity;

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
          height: double.infinity,
          color: Colors.black.withOpacity(backgroundImageOpacity), //added image opacity option for other screens
          colorBlendMode: BlendMode.dstATop,
          ),
          SafeArea(child: child!)
        ]
      )
    );
  }
}