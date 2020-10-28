import 'package:flutter/material.dart';

class MyTheme {
  Color primary;
  Color secondary;
  Color textPrimary;
  Color textSecondary;
  Color cardSearch;
  Color btnNavigation;
  Color cardMusic;
  Color btn1;
  Color btn2;
  Color spinker;
  Color slider;
  Color white = Colors.white;
  Color black = Colors.black;
  MyTheme(
      {this.primary,
      this.secondary,
      this.textPrimary,
      this.textSecondary,
      this.cardSearch,
      this.btnNavigation,
      this.btn1,
      this.btn2,
      this.spinker,
      this.slider});
}

//MyTheme ThemeWhite=MyTheme(primary:,secondary:,textPrimary:,textSecondary:,cardSearch:,btnNavigation:,btn1:,btn2:,spinker:,slider:,)
Decoration linear() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter, // 10% of the width, so there are ten blinds.
      colors: [
        Colors.purple[900],
        Colors.black,
      ], // red to yellow
      tileMode: TileMode.repeated, // repeats the gradient over the canvas
    ),
  );
}

Decoration linear2() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter, // 10% of the width, so there are ten blinds.
      colors: [
        Colors.white,
        //Colors.purple[900],
        Colors.black,
      ], // red to yellow
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
String elmesseri = 'ElMessiri';
String sansita = 'SansitaSwashed';
String unna = 'Unna';
String FontsTitle = sansita;
String Fonts = unna;
