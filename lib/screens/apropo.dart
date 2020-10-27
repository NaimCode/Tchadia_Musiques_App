import 'package:flutter/material.dart';
import 'package:music_app3/constante/colors.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  String image = 'assets/bacground3.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plus'),
        centerTitle: true,
        backgroundColor: Colors.purple[900],
      ),
      body: Container(
        width: double.infinity,
        decoration: linear(),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            height: 20.0,
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
            height: 20.0,
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
            height: 20.0,
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
            height: 20.0,
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
        ]),
      ),
    );
  }
}
