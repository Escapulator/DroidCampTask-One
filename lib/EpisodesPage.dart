import './Podcast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/webfeed.dart';
import './PlayerPage.dart';

class EpisodesPage extends StatelessWidget {
  final url = 'https://dfnramadan.asapmall.com.ng/feed/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('DFN Mobile')),
        //backgroundColor: Colors.grey[800],
        body: Consumer<PodCast>(
          builder: (context, podcast, _) {
            return podcast.feed != null
                ? EpisodeListView(rssFeed: podcast.feed)
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ));
  }
}

class EpisodeListView extends StatelessWidget {
  const EpisodeListView({
    Key key,
    @required this.rssFeed,
  }) : super(key: key);

  final RssFeed rssFeed;

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget> [ 
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              width: MediaQuery.of(context).size.width * 1,
              child: Image.asset('assets/bgicon.jpg')),
            ListView(
        children: rssFeed.items
            .map((f) => ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: Text(
                    f.title,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  /*subtitle: Text(
                    f.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.file_download, color: Colors.white70, size: 30),
                    onPressed: () {
                      Provider.of<PodCast>(context, listen: false).download(f);
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Downloading! ${f.title}')));
                    },
                  ),*/
                  onTap: () {
                    Provider.of<PodCast>(context, listen: false).selectedItem = f;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PlayerPage(),
                      ),
                    );
                  },
                ))
            .toList(),
      ),
          ]);
  }
}
