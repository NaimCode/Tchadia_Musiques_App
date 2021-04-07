import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:music_app3/constante/model.dart';
import 'package:music_app3/constante/widget.dart';
import 'package:music_app3/service/authentification.dart';
import 'package:provider/provider.dart';
import '../obs.dart';
import '../splash.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Utilisateur')
            .doc(isConnected.value)
            .get(),
        builder: (context, doc) {
          if (doc.connectionState == ConnectionState.waiting)
            return chargement();
          if (doc.hasError) {
            Get.rawSnackbar(
                title: 'Erreur',
                message: '',
                icon: Icon(
                  Icons.error_sharp,
                  color: Colors.red,
                ));
            Authentification(FirebaseAuth.instance).deconnection();
          }

          if (doc.hasData) {
            var user = doc.data;
            Utilisateur utilisateur = Utilisateur(
                nom: user['nom'],
                image: user['image'],
                email: user['email'],
                follower: user['follower'],
                admin: user['admin'],
                following: user['following'],
                uid: user['uid']);
            print('cc');
            return ProfilUser(utilisateur);
          } else {
            print('Pas de donne');
            return Splash();
          }
        });
  }
}

class ProfilUser extends StatefulWidget {
  final Utilisateur user;
  ProfilUser(this.user);
  @override
  _ProfilUserState createState() => _ProfilUserState();
}

class _ProfilUserState extends State<ProfilUser> {
  @override
  Widget build(BuildContext context) {
    print('s');
    return Scaffold(
        backgroundColor: Colors.purple,
        body: Container(
            decoration: linear(),
            child: Column(children: [
              Container(
                child: ListTile(
                  leading: widget.user.image == null
                      ? Image.asset('assets/profile.png')
                      : Image.network(widget.user.image),
                  title: Text(widget.user.nom),
                ),
              )
            ])));
  }
}
