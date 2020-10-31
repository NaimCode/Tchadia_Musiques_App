import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:music_app3/constante/model.dart';
import 'package:music_app3/notifier/db_helper.dart';
import 'package:music_app3/screens/home.dart';
import 'package:music_app3/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

debut() {
  var sf = SharedPref();
  var nom = sf.getSharedPrefString('Nom');
  if (nom == "") {
    return Splash();
  } else {
    return Home();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: debut(),
    );
  }
}
