import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:music_app3/constante/model.dart';
import 'package:music_app3/notifier/db_helper.dart';
import 'package:music_app3/screens/chansons.dart';

import 'package:music_app3/screens/music.dart';

class Telechargement extends StatefulWidget {
  @override
  _TelechargementState createState() => _TelechargementState();
}

class _TelechargementState extends State<Telechargement> {
  List<ModelMusic> listModel = [];
  var dbHelper = DataBase();
  PlaylistMusic playlist;
  var allData = [];
  var data = [];
  List allDataFilter = [];
  Future futureBuild;
  String imageAlbum = 'assets/album1.PNG';
  String image = 'assets/BackEqaliseur.jpg';

  void choiceAction(String choice) {
    if (choice == Constants.ecouter) {
      print('Settings');
    } else if (choice == Constants.telecharger) {
      print('Subscribe');
    } else if (choice == Constants.partager) {
      print('SignOut');
    }
  }

  void deleteMusic(ModelMusic model) {
    var count = dbHelper.delete(model);
    final dir = Directory(model.url);
    dir.deleteSync(recursive: true);
    print(count);
    // setState(() {
    //   futureBuild = getData();
    // });
  }

  Future getData() async {
    var employees = await dbHelper.getEmployees();
    setState(() {
      allData = employees;
    });
    return employees;
  }

  void initState() {
    var futureBuild = getData();
    //  searchController.addListener(searchFunction);
    super.initState();
  }

  @override
  void dispose() {
    //  searchController.removeListener(searchFunction);
    searchController.dispose();
    super.dispose();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        elevation: 10.0,
        title: Text('Téléchargements'),
        centerTitle: true,
      ),
      body: Container(
          decoration: linear(),
          child: FutureBuilder<List<ModelMusic>>(
              future: futureBuild,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    color: Colors.grey[900].withOpacity(0),
                    child: SpinKitCircle(
                      color: Colors.white,
                      size: 60,
                    ),
                  );
                } else {
                  return Container(
                    child: ListView.builder(
                      itemCount: allData.length,
                      itemBuilder: (context, index) {
                        // ModelMusic model = ModelMusic(
                        //   titre: snapshot.data[index].data()['titre'],
                        //   artiste: snapshot.data[index].data()['artiste'],
                        //   url: snapshot.data[index].data()['music_url'],
                        //   size: snapshot.data[index].data()['music_size'],
                        // );
                        //listModel.add(model);

                        return InkWell(
                          onTap: () {
                            playlist =
                                PlaylistMusic(listmodel: allData, index: index);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MusicPlayerPage(playlist: playlist),
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.grey[900].withOpacity(0),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 3.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(70)),
                                      child: Stack(children: [
                                        Image.asset(
                                          imageAlbum,
                                          width: 60.0,
                                          height: 70.0,
                                        ),
                                        Container(
                                            width: 60.0,
                                            height: 70.0,
                                            child: Center(
                                                child: Icon(
                                              Icons.play_arrow,
                                              size: 50,
                                              color: Colors.white60,
                                            ))),
                                      ]),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            allData[index].titre,
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                          ),
                                          //SizedBox(height: 7.0),
                                          Text(allData[index].artiste,
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.white60)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(children: [
                                    FlatButton(
                                      onPressed: () {
                                        _showMyDialog(allData[index]);
                                      },
                                      child: Icon(
                                        Icons.delete_outline_outlined,
                                        color: Colors.red[400],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text('03:50',
                                            style: TextStyle(
                                                color: Colors.white30,
                                                fontSize: 10.0))
                                      ],
                                    )
                                  ])
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              })),
    );
  }

  Future<void> _showMyDialog(ModelMusic model) async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.purple[50],
          title: Text(
            'Suppression',
          ),
          content: Container(
            child: SingleChildScrollView(
              child: Center(
                child: ListBody(
                  children: <Widget>[
                    Text('Voulez-vous supprimer cette musiques?'),
                    Text(model.titre + ', ' + model.artiste,
                        style: TextStyle(color: Colors.purple, fontSize: 25.0)),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            Center(
              child: RaisedButton.icon(
                  onPressed: () async {
                    deleteMusic(model);
                    var futureBuild2 = await getData();
                    Navigator.of(context).pop();
                    setState(() {
                      allData = futureBuild2;
                    });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: Text('supprimer',
                      style: TextStyle(
                        color: Colors.red,
                      ))),
            ),
          ],
        );
      },
    );
  }
}
