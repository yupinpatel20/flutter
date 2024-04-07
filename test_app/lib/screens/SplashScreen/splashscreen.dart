import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/home.dart';
import 'package:lottie/lottie.dart';
import 'package:test_app/screens/UserSelectionScreen/user_selection.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => UserTypeSelectionScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                'assets/video/splash.json'
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}