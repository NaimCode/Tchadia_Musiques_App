import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:music_app3/constante/model.dart';

class Contributeru extends StatefulWidget {
  @override
  _ContributeruState createState() => _ContributeruState();
}

class _ContributeruState extends State<Contributeru> {
  String fonttitle = FontsTitle;
  String font = Fonts;
  int first = 7;
  int second = 4;
  int third = 2;
  String firstC = '';
  String secondC = '';
  String thirdC = '';
  List allData = [];
  List data = [];
  List allDataFilter = [];
  Future notFilter;
  var futureBuild;
  Future getData() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection('Music').get();
    QuerySnapshot con =
        await FirebaseFirestore.instance.collection('Contributeurs').get();
    print(con.docs[0].data()['username']);
    qn.docs.forEach((element) {
      ModelMusicFirebase model = ModelMusicFirebase.fromMap(element.data());
      data.add(model);
    });
    allData = data;
    allData.forEach((element) {});
    setState(() {
      allDataFilter = allData;
    });

    return 'Complete';
  }

  void initState() {
    futureBuild = getData();

    super.initState();
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
                  Card(
                    color: Colors.grey[900].withOpacity(0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/1.png',
                            height: 60.0,
                          ),
                          Column(
                            children: [
                              Text('Naim',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: font)),
                              Text('$first',
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
                  Card(
                    color: Colors.grey[900].withOpacity(0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/2.png',
                            height: 60.0,
                          ),
                          Column(
                            children: [
                              Text('Naim',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: font)),
                              Text('$second',
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
                  Card(
                    color: Colors.grey[900].withOpacity(0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/3.png',
                            height: 60.0,
                          ),
                          Column(
                            children: [
                              Text('Naim',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: font)),
                              Text('$third',
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
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
