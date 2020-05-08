import 'package:flutter/cupertino.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class PodCast with ChangeNotifier {
  final pathSuffix = 'Da\'wah Front/Audio/downloads';

  Future<String> _getDownloadPath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    final prefix = dir.uri.path;
    final absolutePath = path.join(prefix, filename);
    return absolutePath;
  }

  final url = 'https://dfnramadan.asapmall.com.ng/feed/';
  RssFeed _feed;
  RssItem _selectedItem;
  Map<String, bool> downloadStatus;

  RssFeed get feed => _feed;
  void parse(String url) async {
    final res = await http.get(url);
    final xmlStr = res.body;
    _feed = RssFeed.parse(xmlStr);
    notifyListeners();
  }

  RssItem get selectedItem => _selectedItem;
  set selectedItem(RssItem value) {
    _selectedItem = value;
    notifyListeners();
  }

  void download(RssItem item) async {
    final client = http.Client();

    final req = http.Request("GET", Uri.parse(item.enclosure.url));
    final res = await client.send(req);

    if(res.statusCode != 200)
        throw Exception('Unexpected HTTP errorcode: ${res.statusCode}');
        

    /*res.stream.listen((byte){
      print('Recieved ${byte.length} bytes');
    });*/

    final file = File(await _getDownloadPath(path.split(item.enclosure.url).last));
        //file.openWrite();
        res.stream.pipe(file.openWrite()).whenComplete((){
          print('Download Complete');
        });

    /*http.StreamedRequest req =
        http.StreamedRequest('GET', Uri.parse(item.guid));
        final res = await req.send();
        if(res.statusCode != 200)
        throw Exception('Unexpected HTTP errorcode: ${res.statusCode}');
        final file = File(await _getDownloadPath(path.split(item.guid).last));
        //file.openWrite();
        res.stream.pipe(file.openWrite()).whenComplete((){
          print('Download Complete');
        });*/
  }
}
