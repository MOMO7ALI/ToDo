import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/theme_provider.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String routeName = 'splash';

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ThemeProvider>(context);

    Timer(Duration(seconds: 2), () => navigateToHome(context));

    return Scaffold(
      backgroundColor: prov.themeMode==ThemeMode.light?Color(0xFFDFECDB):Color(0xFF060e1e),

      body: Center(
        heightFactor: double.infinity,
        child: Image.asset(prov.themeMode==ThemeMode.light?'assets/images/splash_background.png':'assets/images/splash – 1.png'),
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
