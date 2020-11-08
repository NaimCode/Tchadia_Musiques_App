import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:music_app3/constante/model.dart';
import 'package:music_app3/screens/conributeurmusic.dart';

class Contributeru extends StatefulWidget {
  @override
  _ContributeruState createState() => _ContributeruState();
}

class _ContributeruState extends State<Contributeru> {
  String fonttitle = FontsTitle;
  String font = Fonts;

  List<Contributeur> conL = [];
  int first = 0;
  int second = 0;
  int third = 0;
  String firstC = '';
  String secondC = '';
  String thirdC = '';

  List data = [];

  Future notFilter;
  var futureBuild;

  Future getData() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection('Music').get();
    QuerySnapshot con =
        await FirebaseFirestore.instance.collection('Contributeurs').get();

    //print(con.docs[0].data()['username']);
    qn.docs.forEach((element) {
      ModelMusicFirebase model = ModelMusicFirebase.fromMap(element.data());
      data.add(model);
    });
    con.docs.forEach((element) {
      Contributeur c =
          Contributeur(username: element.data()['username'], numMusic: 0);
      data.forEach((element) {
        if (element.contributeur == c.username) {
          c.numMusic++;
        }
      });
      conL.add(c);
    });
    print(conL.length);
    conL.sort((a, b) => a.numMusic.compareTo(b.numMusic));
    conL = conL.reversed.toList();

    return 'Complete';
  }

  void initState() {
    futureBuild = getData();

    super.initState();
  }

  pushFunction(String con, String rank) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContributeurMusic(con: con, rank: rank),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: futureBuild,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: linear(),
              child: SpinKitCircle(
                color: Colors.white,
                size: 60.0,
              ),
            );
          } else {
            return Container(
              decoration: linear(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/upload.jpg',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Top 3 contributeurs',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: font),
                    ),
                  ),
                  (conL[0] != null)
                      ? InkWell(
                          onTap: () {
                            pushFunction(conL[0].username, 'assets/1.png');
                          },
                          child: Card(
                            color: Colors.grey[900].withOpacity(0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/1.png',
                                    height: 60.0,
                                  ),
                                  Column(
                                    children: [
                                      Text(conL[0].username,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25.0,
                                              fontFamily: font)),
                                      Text('${conL[0].numMusic}',
                                          style: TextStyle(
                                              color: Colors.white60,
                                              fontSize: 18.0,
                                              fontFamily: fonttitle)),
                                    ],
                                  ),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.white60,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : Text(''),
                  (conL[1] != null)
                      ? InkWell(
                          onTap: () {
                            pushFunction(conL[1].username, 'assets/2.png');
                          },
                          child: Card(
                            color: Colors.grey[900].withOpacity(0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/2.png',
                                    height: 60.0,
                                  ),
                                  Column(
                                    children: [
                                      Text(conL[1].username,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25.0,
                                              fontFamily: font)),
                                      Text('${conL[1].numMusic}',
                                          style: TextStyle(
                                              color: Colors.white60,
                                              fontSize: 18.0,
                                              fontFamily: fonttitle)),
                                    ],
                                  ),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.white60,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : Text(''),
                  (conL[2] != null)
                      ? InkWell(
                          onTap: () {
                            pushFunction(conL[2].username, 'assets/3.png');
                          },
                          child: Card(
                            color: Colors.grey[900].withOpacity(0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/3.png',
                                    height: 60.0,
                                  ),
                                  Column(
                                    children: [
                                      Text(conL[2].username,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25.0,
                                              fontFamily: font)),
                                      Text('${conL[2].numMusic}',
                                          style: TextStyle(
                                              color: Colors.white60,
                                              fontSize: 18.0,
                                              fontFamily: fonttitle)),
                                    ],
                                  ),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.white60,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : Text(''),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
