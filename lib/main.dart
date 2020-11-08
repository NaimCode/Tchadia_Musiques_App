import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:music_app3/constante/model.dart';
import 'package:music_app3/notifier/db_helper.dart';
import 'package:music_app3/screens/home.dart';
import 'package:music_app3/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var nom = prefs.getString('Nom');
  await Firebase.initializeApp();

  runApp(MyApp(nom));
}

class MyApp extends StatelessWidget {
  debut() {
    if (nom != null) {
      return Home();
    } else {
      return Splash();
    }
  }

  String nom;
  MyApp(this.nom);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: debut(),
      debugShowCheckedModeBanner: false,
    );
  }
}
