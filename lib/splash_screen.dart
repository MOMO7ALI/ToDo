import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String routeName = 'splash';

  @override
  Widget build(BuildContext context) {

    Timer(Duration(seconds: 2), () => navigateToHome(context));

    return Scaffold(
      backgroundColor: Color(0xFFDFECDB),

      body: Center(
        heightFactor: double.infinity,
        child: Image.asset('assets/images/splash_background.png'),
      ),
    );
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}
