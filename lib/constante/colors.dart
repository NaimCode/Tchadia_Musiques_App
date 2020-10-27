import 'package:flutter/material.dart';

class MyTheme {
  Color primary;
  Color secondary;
  Color thirdy;
  MyTheme({this.primary, this.secondary, this.thirdy});
}

//MyTheme themeBlueNoir=MyTheme(primary: 0xFF3100FF,secondary: )
Decoration linear() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter, // 10% of the width, so there are ten blinds.
      colors: [Colors.purple[900], Colors.black], // red to yellow
      tileMode: TileMode.repeated, // repeats the gradient over the canvas
    ),
  );
}

Decoration linear2() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter, // 10% of the width, so there are ten blinds.
      colors: [Colors.purple[900], Colors.black], // red to yellow
      tileMode: TileMode.repeated, // repeats the gradient over the canvas
    ),
  );
}

Decoration imageBack() {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/BackMusicPlayer.png"),
      fit: BoxFit.cover,
    ),
  );
}

class Music {
  String url;
  String titre;
  String artiste;
  int duree;
  Music({this.artiste, this.titre, this.url, this.duree});
}

Color back = Color(0xff130E25);
