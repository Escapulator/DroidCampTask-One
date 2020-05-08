import './PlaybackButton.dart';
import 'package:flutter/material.dart';

class AudioControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PlaybackButtons()
      ],
    );
  }
}