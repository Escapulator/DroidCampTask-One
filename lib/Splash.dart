import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import './HomeScreen.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      image: Image.asset('assets/splashcon.jpg'),
      photoSize: 200.0,
      navigateAfterSeconds: HomeScreen(),
    );
  }
}
