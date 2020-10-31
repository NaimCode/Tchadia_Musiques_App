import 'package:flutter/material.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:music_app3/constante/model.dart';
import 'package:music_app3/screens/artiste.dart';
import 'package:music_app3/screens/download.dart';
import 'package:music_app3/screens/music.dart';

class Chansons extends StatefulWidget {
  @override
  _ChansonsState createState() => _ChansonsState();
}

class Constants {
  static const String telecharger = 'Télécharger';
  static const String partager = 'Partager';
  static const String ecouter = 'Ecouter';

  static const List<String> choices = <String>[ecouter, telecharger, partager];
}

class _ChansonsState extends State<Chansons> {
  String fonttitle = FontsTitle;
  String font = Fonts;
  List<ModelMusic> listModel = [];
  PlaylistMusic playlist;
  List allData = [];
  List data = [];
  List allDataFilter = [];
  Future notFilter;
  String imageAlbum = 'assets/album2.PNG';
  String image = 'assets/BackEqaliseur.jpg';
  var futureBuild;

  Future getData() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection('Music').get();

    qn.docs.forEach((element) {
      ModelMusicFirebase model = ModelMusicFirebase.fromMap(element.data());
      data.add(model);
    });
    setState(() {
      allData = data;
      allDataFilter = allData;
    });
    return 'Complete';
  }

  void initState() {
    futureBuild = getData();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: linear(),
      child: FutureBuilder(
          future: futureBuild,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: Colors.grey[900].withOpacity(0),
                child: SpinKitCircle(
                  color: Colors.white,
                  size: 60.0,
                ),
              );
            } else {
              return Scaffold(
                body: Container(
                  decoration: linear(),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          width: double.infinity,
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Tous les artistes...',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: fonttitle,
                                      fontSize: 20.0),
                                ),
                              ),
                              Icon(Icons.navigate_next,
                                  color: Colors.white, size: 30.0)
                            ],
                          ),
                        ),
                      ),
                      Expanded(flex: 2, child: artistView(allData)),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Artistes(
                                  pop: true,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Toutes les musiques...',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: fonttitle,
                                      fontSize: 20.0),
                                ),
                              ),
                              Icon(Icons.navigate_next,
                                  color: Colors.white, size: 30.0)
                            ],
                          ),
                        ),
                      ),
                      Expanded(flex: 2, child: listView(allDataFilter)),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  Container artistView(List snapshot) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allDataFilter.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              listModel.clear();
              for (var model in allDataFilter) {
                ModelMusic m = ModelMusic(
                  titre: model.titre,
                  artiste: model.artiste,
                  url: model.url,
                  size: model.size,
                );
                listModel.add(m);
              }

              playlist = PlaylistMusic(listmodel: listModel, index: index);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusicPlayerPage(playlist: playlist),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 25.0),
              width: 150.0,
              // height: 80.0,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(40.0)),
                child: Card(
                  elevation: 10.0,
                  color: Colors.grey[900],
                  child: Center(
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            snapshot[index].image,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            snapshot[index].titre,
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontFamily: fonttitle,
                                fontWeight: FontWeight.bold),
                          ),
                          //SizedBox(height: 7.0),
                          Text(snapshot[index].artiste,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white60)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container listView(List snapshot) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, //allDataFilter.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              listModel.clear();
              for (var model in allDataFilter) {
                ModelMusic m = ModelMusic(
                  titre: model.titre,
                  artiste: model.artiste,
                  url: model.url,
                  size: model.size,
                  time: model.time,
                  image: model.image,
                  contributeur: model.contributeur,
                );
                listModel.add(m);
              }

              playlist = PlaylistMusic(listmodel: listModel, index: index);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusicPlayerPage(playlist: playlist),
                ),
              );
            },
            child: lastItem(snapshot, index),
          );
        },
      ),
    );
  }

  ClipRRect lastItem(List snapshot, int index) {
    if (index == 4 && snapshot[4] != null) {
      return ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0)),
        child: Container(
          margin: EdgeInsets.only(bottom: 15.0),
          width: 150.0,
          //  height: 80.0,
          child: Card(
            elevation: 10.0,
            color: Colors.grey[900],
            child: Center(
              child: Container(
                  alignment: Alignment.bottomLeft,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        snapshot[index].image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              snapshot[index].titre,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontFamily: fonttitle,
                                  fontWeight: FontWeight.bold),
                            ),
                            //SizedBox(height: 7.0),
                            Text(snapshot[index].artiste,
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white60)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              color: Colors.black.withOpacity(0.7),
                              width: 60.0,
                              child: Center(
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Artistes(
                                          pop: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.navigate_next,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0)),
        child: Container(
          margin: EdgeInsets.only(right: 25.0, bottom: 15.0),
          width: 150.0,
          //  height: 80.0,
          child: Card(
            elevation: 10.0,
            color: Colors.grey[900],
            child: Center(
              child: Container(
                alignment: Alignment.bottomLeft,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      snapshot[index].image,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      snapshot[index].titre,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontFamily: fonttitle,
                          fontWeight: FontWeight.bold),
                    ),
                    //SizedBox(height: 7.0),
                    Text(snapshot[index].artiste,
                        style:
                            TextStyle(fontSize: 12.0, color: Colors.white60)),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
