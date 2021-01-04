import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app3/constante/model.dart';
import 'package:music_app3/constante/widget.dart';
import 'package:music_app3/notifier/db_helper.dart';
import 'package:music_app3/obs.dart';
import 'package:music_app3/screens/home.dart';
import 'package:music_app3/screens/profil.dart';
import 'package:music_app3/splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'service/authentification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Authentification>(
          create: (_) => Authentification(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (conext) =>
                context.read<Authentification>().authStateChanges),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bousta',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => Tchadia()),
          // GetPage(
          //   name: '/add',
          //   page: () => AjoutRecette(),
          // ),
          // GetPage(
          //   name: '/recette',
          //   page: () => RecettePage(),
          // ),
        ],
      ),
    );
  }
}

class Tchadia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<Authentification>();

    return StreamBuilder<User>(
      stream: firebaseUser.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return chargement();
        if (!snapshot.hasData) {
          isConnected.value = '';
          return Home();
        } else {
          print(snapshot.data.uid);
          isConnected.value = snapshot.data.uid;
          return
              // StreamBuilder(
              //     stream: FirebaseFirestore.instance
              //         .collection('Chef')
              //         .doc(snapshot.data.uid)
              //         .snapshots(),
              //     builder: (context, doc) {
              //       if (doc.connectionState == ConnectionState.waiting)
              //         return chargement();
              //       if (doc.hasError) {
              //         Get.rawSnackbar(
              //             title: 'Erreur',
              //             message: '',
              //             icon: Icon(
              //               Icons.error_sharp,
              //               color: Colors.red,
              //             ));
              //         Authentification(FirebaseAuth.instance).deconnection();
              //       }
              //       if (doc.hasData) {
              //         var user = doc.data;

              //         // String imageurl = user['image'] ?? profile;

              //         return ProxyProvider0(
              //             update: (_, __) => Utilisateur(
              //                 nom: user['nom'],
              //                 image: user['image'],
              //                 email: user['email'],
              //                 follower: user['follower'],
              //                 admin: user['admin'],
              //                 following: user['following'],
              //                 uid: user['uid']),
              //             child:
              Home();
          //   } else
          //     return chargement();
          // });
        }
      },
    );
  }
}
