import './Podcast.dart';
import 'package:flutter/material.dart';
import './EpisodesPage.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final url = 'https://dfnramadan.asapmall.com.ng/feed/';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_) => PodCast()..parse(url),
          child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: EpisodesPage(),
        title: 'DFNCast',
      ),
    );
  }
}