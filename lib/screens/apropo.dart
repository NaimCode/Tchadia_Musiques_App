import 'package:flutter/material.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:music_app3/notifier/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      width: MediaQuery.of(context).size.width / 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('$nom', style: TextStyle(fontFamily: fonttitle)),
          centerTitle: true,
          leading: FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.expand_more,
                color: Colors.white,
              )),
          backgroundColor: Colors.purple[900],
        ),
        body: Container(
          width: double.infinity,
          decoration: linear(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/album1.PNG',
                        ),
                        radius: 110,
                      ),
                    ),
                  ],
                ),
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
                  onPressed: () {},
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
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.people_alt_outlined, color: Colors.white70),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'Contributeurs',
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
      ),
    );
  }
}
