import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:music_app3/notifier/db_helper.dart';
import 'package:music_app3/screens/apropo.dart';
import 'package:music_app3/screens/allmusic.dart';
import 'package:music_app3/screens/artistList.dart';
import 'package:music_app3/screens/contributeurs.dart';
import 'package:music_app3/screens/index.dart';
import 'package:music_app3/screens/profil.dart';
import 'package:music_app3/screens/profile.dart';
import 'package:music_app3/screens/upload.dart';
import 'package:music_app3/screens/telechargement.dart';
import 'package:music_app3/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var nom = '';
  var nom1;

  String fonttitle = FontsTitle;
  String font = Fonts;
  int currentindex = 1;
  Text appTitle(int i) {
    switch (i) {
      case 0:
        return Text('Téléchargements',
            style: TextStyle(
                fontFamily: fonttitle,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0));
        break;
      case 2:
        return Text('Artistes',
            style: TextStyle(
                fontFamily: fonttitle,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0));
        break;

      case 1:
        return Text('Amal Yachi',
            style: TextStyle(
                fontFamily: fonttitle,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0));
        break;
      case 3:
        return Text('Musiques',
            style: TextStyle(
                fontFamily: fonttitle,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0));
        break;
      default:
        return Text('');
    }
    // if (i == 0) {
    //   return Text('Téléchargements',
    //       style: TextStyle(
    //           fontFamily: fonttitle,
    //           fontWeight: FontWeight.bold,
    //           letterSpacing: 3.0));
    // } else {
    //   if (i == 1) {
    //     return Text('Tchadia',
    //         style: TextStyle(
    //             fontFamily: fonttitle,
    //             fontWeight: FontWeight.bold,
    //             letterSpacing: 3.0));
    //   } else {

    //   }
    // }
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

  //
  @override
  Widget build(BuildContext context) {
    List tabs = [
      Telechargement(),

      Chansons(),

      //MusicPlayerPage(),
      Artistes(pop: false),
    ];

    return Scaffold(
      endDrawer: Drawer(
        child: Information(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.purple[700],
        index: 1,
        backgroundColor: Colors.black,
        color: Colors.purple[900],
        height: 56.0,
        items: <Widget>[
          Icon(
            Icons.cloud_download_rounded,
            size: 25,
            color: Colors.white70,
          ),
          Icon(
            Icons.home,
            size: 25,
            color: Colors.white70,
          ),
          Icon(
            Icons.music_note,
            size: 25,
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => Upload(),
      //       ),
      //     );
      //   },
      //   elevation: 10.0,
      //   child: Icon(Icons.add, color: Colors.black),
      //   backgroundColor: Colors.amber[900],
      // ),
      appBar: AppBar(
        leading: Lottie.asset('assets/logoAnimated.json'),
        title: appTitle(currentindex),
        backgroundColor: Colors.purple[900],
        elevation: appTitleEle(currentindex),
        centerTitle: true,
      ),
    );
  }
}
