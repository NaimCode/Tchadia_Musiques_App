import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:music_app3/notifier/db_helper.dart';
import 'package:music_app3/screens/apropo.dart';
import 'package:music_app3/screens/artiste.dart';
import 'package:music_app3/screens/chansons.dart';
import 'package:music_app3/screens/upload.dart';
import 'package:music_app3/screens/telechargement.dart';
import 'package:music_app3/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String fonttitle = FontsTitle;
  String font = Fonts;
  int currentindex = 1;
  Text appTitle(int i) {
    if (i == 0) {
      return Text('Téléchargements',
          style: TextStyle(
              fontFamily: fonttitle,
              fontWeight: FontWeight.bold,
              letterSpacing: 3.0));
    } else {
      if (i == 1) {
        return Text('Tchadia',
            style: TextStyle(
                fontFamily: fonttitle,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0));
      } else {
        return Text('Musiques',
            style: TextStyle(
                fontFamily: fonttitle,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0));
      }
    }
  }

  double appTitleEle(int i) {
    if (i == 0) {
      return 10.0;
    } else {
      if (i == 1) {
        return 0.0;
      } else {
        return 0.0;
      }
    }
  }

  //var nom = prefs.getString('Nom') ?? "";
  @override
  Widget build(BuildContext context) {
    List tabs = [
      Telechargement(),
      // Upload(),
      Chansons(),
      //MusicPlayerPage(),
      Artistes(pop: false),
      // Information()
    ];

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.purple[700],
        index: 1,
        backgroundColor: Colors.black,
        color: Colors.purple[900],
        height: 60.0,
        items: <Widget>[
          Icon(
            Icons.cloud_download_rounded,
            size: 35,
            color: Colors.white70,
          ),
          Icon(
            Icons.home,
            size: 35,
            color: Colors.white70,
          ),
          Icon(
            Icons.music_note,
            size: 35,
            color: Colors.white70,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Upload(),
            ),
          );
        },
        elevation: 10.0,
        child: Icon(Icons.add),
        backgroundColor: Colors.amber[900],
      ),
      appBar: AppBar(
        leading: Container(),
        title: appTitle(currentindex),
        backgroundColor: Colors.purple[900],
        elevation: appTitleEle(currentindex),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Information(),
                  ));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 23.0),
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 25.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
