import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.child, this.backgroundImageOpacity = 0.0, this.bottomNavigationBar,});
  final Widget? child;
  final double backgroundImageOpacity;
  final Widget? bottomNavigationBar;

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
          SafeArea(child: child!),
          if (bottomNavigationBar != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: bottomNavigationBar!,
            ),
        ]
      )
    );
  }
}