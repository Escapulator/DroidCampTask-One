import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  

  @override
  void initState(){
  super.initState();
  Timer(Duration(seconds: 3), (){
    Navigator.of(context).pushReplacementNamed('Home');
  });
}
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Image.asset('assets/images/splashscreen.png'),
      ),
    );
  }
}
