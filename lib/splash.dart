import 'package:flutter/material.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:music_app3/notifier/db_helper.dart';
import 'package:music_app3/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String fonttitle = FontsTitle;
  String font = Fonts;
  TextEditingController titreInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 5.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Text(
                  'TCHADIA',
                  style: TextStyle(
                      color: Colors.indigo[900],
                      fontFamily: font,
                      fontSize: 40.0),
                ),
              ),
              Image.asset('assets/splashIllustration.png'),
              Container(
                child: Text(
                  'Découvrez la première application musicale tchadienne!',
                  style: TextStyle(
                      color: Colors.indigo[900],
                      fontFamily: font,
                      fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: RaisedButton(
                  color: Colors.indigo[900],
                  onPressed: () {
                    FirstDialog();
                  },
                  child: Container(
                    height: 60.0,
                    child: Center(
                      child: Text(
                        'COMMENCER',
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontFamily: 'Unna'),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  FirstDialog() {
    TextEditingController nomInput = TextEditingController();
    bool erreur = false;
    setSFNom() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('Nom', nomInput.text);
      print('Nom ajouter');
    }

    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.purple[50],
          title: Text(
            'Ajouter un nom d\'utilisateur',
            style: TextStyle(
              fontFamily: fonttitle,
            ),
          ),
          content: Container(
            child: SingleChildScrollView(
              child: Center(
                child: ListBody(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Nom'),
                      controller: nomInput,
                    ),
                    Text('Veuillez saisir un nom avec au moins 4 caractères.',
                        style: TextStyle(color: Colors.black38, fontSize: 12.0))
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            Container(
              //height: 40.0,
              width: 100.0,
              child: RaisedButton(
                  color: Colors.indigo[900],
                  onPressed: () {
                    if (nomInput.text.length < 4) {
                      setState(() {
                        nomInput.clear();
                      });
                    } else {
                      setSFNom();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ));
                    }
                  },
                  child: Text('valider',
                      style:
                          TextStyle(color: Colors.white, letterSpacing: 3.0))),
            )
          ],
        );
      },
    );
  }
}
