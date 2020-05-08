import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/flutter_sound_player.dart';
import './Podcast.dart';
import 'package:provider/provider.dart';

class PlaybackButtons extends StatefulWidget {
  @override
  _PlaybackButtonState createState() => _PlaybackButtonState();
}

class _PlaybackButtonState extends State<PlaybackButtons> {
  bool _isPlaying = false;
  FlutterSound _sound;
  double _playPosition;
  Stream<PlayStatus> _playSubscription;

  @override
  void initState() {
    super.initState();
    _sound = FlutterSound();
    _playPosition = 0;
  }

  void _stop() async {
    await _sound.stopPlayer();
    setState(() => _isPlaying = false);
  }

  void _play(String url) async {
      await _sound.startPlayer(url);
    _playSubscription = _sound.onPlayerStateChanged
      ..listen((e) {
        if (e != null) {
          _playPosition = e.currentPosition;
          setState(() => _playPosition = (e.currentPosition / e.duration));
        }
      });
    setState(() => _isPlaying = true);
  }

  void _pause() async {
    await _sound.pausePlayer();
    setState(() => _isPlaying = false);
  }

  void _resume() async {
    await _sound.resumePlayer();
    setState(() => _isPlaying = true);
  }

  _rewind() {}
  _forward() {}

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<PodCast>(context).selectedItem;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Slider(
          value: _playPosition,
          onChanged: null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: _isPlaying
                  ? Icon(
                      Icons.stop,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
              onPressed: () {
                if (_isPlaying) {
                  _stop();
                } else {
                  _play(item.enclosure.url);
                }
              },
            ),
            IconButton(
                icon: Icon(
                  Icons.fast_rewind,
                  color: Colors.white,
                ),
                onPressed: _rewind()),
            IconButton(
              icon: _isPlaying
                  ? Icon(
                      Icons.pause,
                      color: Colors.white,
                    )
                  : Icon(Icons.play_circle_filled, color: Colors.white),
              onPressed: () {
                if (_isPlaying) {
                  _pause();
                } else {
                  _resume();
                }
              },
            ),
            IconButton(
              icon: Icon(
                Icons.fast_forward,
                color: Colors.white,
              ),
              onPressed: _forward(),
            ),
          ],
        ),
      ],
    );
  }
}
