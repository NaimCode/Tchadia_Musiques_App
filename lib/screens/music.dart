import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app3/constante/model.dart';
import 'package:music_app3/screens/download.dart';

// ignore: must_be_immutable
class MusicPlayerPage extends StatefulWidget {
  PlaylistMusic playlist;
  MusicPlayerPage({this.playlist});
  @override
  _MusicPalyerPageState createState() => _MusicPalyerPageState();
}

class _MusicPalyerPageState extends State<MusicPlayerPage> {
  String fonttitle = FontsTitle;
  String font = Fonts;
  PlaylistMusic playlist;
  bool chargementMusic = true;
  double currentDuration = 0.0;
  double currentVolume = 0.6;
  double maxDuration = 200.0;
  bool isplaying = true;
  bool loop = false;
  Duration duration = Duration(seconds: 200);
  Duration durationDebut = Duration(seconds: 0);
  final player = AudioPlayer();

  String imageMusic = 'assets/image2.jpg';
  void loopFunction() {
    if (loop) {
      musicInitialisation(playlist.index);
    } else {
      playlistNext();
    }
  }

  void increase() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      if (!isplaying) {
      } else {
        if (currentDuration >= (duration.inSeconds.toDouble() - 1.0)) {
          loopFunction();
        }
        setState(() {
          currentDuration++;
          durationDebut = Duration(seconds: currentDuration.toInt());
        });
      }
    });
  }

  void dispose() async {
    super.dispose();
    player.stop();

    isplaying = false;
  }

  void initState() {
    super.initState();
    playlist = widget.playlist;
    musicInitialisation(playlist.index);
    increase();
  }

  format(Duration d) => d.toString().substring(2, 7);
  void musicInitialisation(int x) async {
    player.stop();
    duration = await player.setUrl(playlist.listmodel[x].url);
    setState(() {
      chargementMusic = false;
    });
    player.play();
  }

  void checkEvent() {
    player.playerStateStream.listen((event) {
      if (event.playing) {
      } else {
        playlistNext();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (chargementMusic) {
      return Scaffold(
          body: Container(
        decoration: linear(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitChasingDots(
                color: Colors.white,
                size: 90.0,
              ),
              SizedBox(
                height: 20,
              ),
              Text('Chargement...', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ));
    } else {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.purple[900],
          actions: [
            RaisedButton.icon(
              color: Colors.purple[900],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Download(model: playlist.listmodel[playlist.index]),
                  ),
                );
              },
              icon: Icon(
                Icons.download_sharp,
                size: 25,
                color: Colors.white70,
              ),
              label: Text(
                playlist.listmodel[playlist.index].size,
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
        body: WillPopScope(
          // ignore: missing_return
          onWillPop: () {
            Navigator.pop(context);
          },
          child: Container(
            decoration: linear(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 15.0,
                    color: Colors.purple[800],
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          //'$currentSlider',
                          playlist.listmodel[playlist.index].titre,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontFamily: fonttitle),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          playlist.listmodel[playlist.index].artiste,
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 25.0,
                              fontFamily: font),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/upload.jpg',
                    ),
                    radius: 120,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                        elevation: 15.0,
                        color: Colors.grey[900].withOpacity(0),
                        child: Slider(
                          min: 0,
                          max: duration.inSeconds.toDouble(),
                          value: currentDuration,
                          onChanged: (value) {
                            seek(value);
                          },
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(format(durationDebut),
                            style: TextStyle(color: Colors.white30)),
                        Text(format(duration),
                            style: TextStyle(color: Colors.white30)),
                      ],
                    ),
                    Card(
                      elevation: 15.0,
                      color: Colors.grey[900].withOpacity(0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            elevation: 0.0,
                            color: Colors.grey[900].withOpacity(0),
                            onPressed: playlistBack,
                            child: Icon(
                              Icons.skip_previous_outlined,
                              size: 35,
                              color: Colors.white30,
                            ),
                          ),
                          RaisedButton(
                            elevation: 0.0,
                            color: Colors.grey[900].withOpacity(0),
                            onPressed: () {
                              setState(() {
                                if (isplaying) {
                                  player.pause();
                                  isplaying = false;
                                  // increase();
                                } else {
                                  player.play();
                                  isplaying = true;
                                  // increase();
                                }
                              });
                            },
                            child: Icon(
                              isplaying
                                  ? Icons.pause_circle_filled_rounded
                                  : Icons.play_circle_fill_rounded,
                              size: 100.0,
                              color: Colors.purple[200],
                            ),
                          ),
                          RaisedButton(
                            elevation: 0.0,
                            color: Colors.grey[900].withOpacity(0),
                            onPressed: playlistNext,
                            child: Icon(
                              Icons.skip_next_outlined,
                              size: 35,
                              color: Colors.white30,
                            ),
                          )
                        ],
                      ),
                    ),
                    Card(
                      elevation: 15.0,
                      color: Colors.grey[900].withOpacity(0),
                      child: Row(
                        children: [
                          RaisedButton(
                            elevation: 0.0,
                            color: Colors.grey[900].withOpacity(0),
                            onPressed: null,
                            child: Icon(
                              Icons.volume_down_outlined,
                              size: 35,
                              color: Colors.white30,
                            ),
                          ),
                          Slider(
                            min: 0,
                            max: 1,
                            divisions: 5,
                            value: currentVolume,
                            onChanged: (value) {
                              setState(() {
                                player.setVolume(value);
                                currentVolume = value;
                              });
                            },
                          ),
                          RaisedButton(
                            elevation: 0.0,
                            color: Colors.grey[900].withOpacity(0),
                            onPressed: null,
                            child: Icon(
                              Icons.volume_up_outlined,
                              size: 35,
                              color: Colors.white30,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  void playlistNext() {
    if (playlist.index < (playlist.listmodel.length - 1)) {
      playlist.index++;
      setState(() {
        currentDuration = 0.0;
        durationDebut = Duration(seconds: currentDuration.toInt());
      });
    } else {
      playlist.index = 0;
    }

    musicInitialisation(playlist.index);
    setState(() {
      currentDuration = 0.0;
      durationDebut = Duration(seconds: currentDuration.toInt());
    });
  }

  void playlistBack() async {
    setState(() async {
      if (playlist.index > 0) {
        playlist.index--;
      } else
        playlist.index = 0;
      musicInitialisation(playlist.index);
    });
  }

  void seek(double x) async {
    await player.seek(Duration(seconds: x.toInt()));
    setState(() {
      currentDuration = x;
    });
  }
}
