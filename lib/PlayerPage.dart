import './Player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './Podcast.dart';

class PlayerPage extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Provider.of<PodCast>(context).selectedItem.title),
        ),
        body: Center(child: SafeArea(child: Player())),
    );
  }
}
