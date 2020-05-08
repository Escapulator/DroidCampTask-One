import './AudioControls.dart';
import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[800],
          body: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(70),
            child: Container(
                color: Colors.lightGreen,
                height: MediaQuery.of(context).size.height * 0.744,
                width: MediaQuery.of(context).size.width * 1,
                child: Image.asset('assets/img.jpg')),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.135,
            width: MediaQuery.of(context).size.width * 1,
            color: Colors.green[800],
            child: AudioControls(),
          ),
        ],
      ),
    );
  }
}
