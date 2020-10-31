import 'package:flutter/material.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:music_app3/notifier/db_helper.dart';
import 'package:music_app3/screens/home.dart';

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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      decoration: imageSplash(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RaisedButton(
            color: Color(0xff654BFF),
            onPressed: () {
              FirstDialog();
            },
            child: Container(
              height: 60.0,
              child: Center(
                child: Text(
                  'COMMENCER',
                  style: TextStyle(
                      fontSize: 30.0, color: Colors.white, fontFamily: 'Unna'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  FirstDialog() {
    TextEditingController nomInput = TextEditingController();
    bool erreur = false;
    var sf = SharedPref();
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
                  color: Color(0xff654BFF),
                  onPressed: () {
                    if (nomInput.text.length < 4) {
                      setState(() {
                        nomInput.clear();
                      });
                    } else {
                      sf.setSharedPref('Nom', 'String', nomInput.text);
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