import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_assignmentt/screens/home_screen.dart';
import 'package:my_assignmentt/screens/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to the home screen after a delay
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0), // Animate from 0 to 1
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut, // Smooth animation curve
          builder: (context, value, child) {
            return Transform.scale(
              scale: 0.5 + (value * 0.5), // Scale from 0.5x to 1x
              child: Opacity(
                opacity: value, // Fade in the text
                child: const Text(
                  "Assignment of W3DEV",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
