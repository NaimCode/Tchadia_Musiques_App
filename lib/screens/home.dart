import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_app3/screens/apropo.dart';
import 'package:music_app3/screens/artiste.dart';
import 'package:music_app3/screens/chansons.dart';
import 'package:music_app3/screens/upload.dart';
import 'package:music_app3/screens/telechargement.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentindex = 2;
  @override
  Widget build(BuildContext context) {
    List tabs = [
      Telechargement(),
      Upload(),
      Chansons(),
      //MusicPlayerPage(),
      Artistes(),
      Information()
    ];
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.amber[600],
        index: 2,
        backgroundColor: Colors.black,
        color: Colors.purple[900],
        height: 60.0,
        items: <Widget>[
          Icon(
            Icons.cloud_download_rounded,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.file_upload,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.music_note_rounded,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.search_outlined,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.menu,
            size: 25,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
          //Handle button tap
        },
      ),
      body: tabs[currentindex],
    );
  }
}
