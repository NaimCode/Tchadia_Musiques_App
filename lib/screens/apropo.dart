import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:music_app3/notifier/db_helper.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../extra.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  getSFNom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      nom = prefs.getString('Nom') ?? "Annonyme";
    });
  }

  String fonttitle = FontsTitle;
  String nom = '';
  String font = Fonts;
  String image = 'assets/bacground3.jpg';
  void initState() {
    getSFNom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: double.infinity,
        decoration: linear(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Colors.grey[900].withOpacity(0),
              child: FlatButton(
                onPressed: () {
                  Share.share(
                      'Email: naim.developer@outlook.com, Tel: 00212700480681',
                      subject: 'Naim Abdelkerim');
                },
                child: Row(
                  children: [
                    Icon(Icons.contact_mail, color: Colors.white70),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Contactez-nous',
                      style: TextStyle(color: Colors.white70),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              color: Colors.grey[900].withOpacity(0),
              child: FlatButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.share_outlined, color: Colors.white70),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Partager',
                      style: TextStyle(color: Colors.white70),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              color: Colors.grey[900].withOpacity(0),
              child: FlatButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.star_border_outlined, color: Colors.white70),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Notez-nous',
                      style: TextStyle(color: Colors.white70),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              color: Colors.grey[900].withOpacity(0),
              child: FlatButton(
                onPressed: () {
                  Get.to(Policity());
                },
                child: Row(
                  children: [
                    Icon(Icons.privacy_tip_outlined, color: Colors.white70),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Politique de confidentialité',
                      style: TextStyle(color: Colors.white70),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              color: Colors.grey[900].withOpacity(0),
              child: FlatButton(
                onPressed: () {
                  Get.to(Termes());
                },
                child: Row(
                  children: [
                    Icon(Icons.vpn_key, color: Colors.white70),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Termes et conditions',
                      style: TextStyle(color: Colors.white70),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              color: Colors.grey[900].withOpacity(0),
              child: FlatButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.white70),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Informations',
                      style: TextStyle(color: Colors.white70),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
