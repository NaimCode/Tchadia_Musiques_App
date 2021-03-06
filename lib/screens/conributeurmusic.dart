import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:music_app3/constante/model.dart';
import 'package:music_app3/screens/download.dart';
import 'package:music_app3/screens/index.dart';
import 'package:music_app3/screens/music.dart';

// ignore: must_be_immutable
class ContributeurMusic extends StatefulWidget {
  String con;
  String rank;
  ContributeurMusic({this.con, this.rank});
  @override
  _ContributeurMusicState createState() => _ContributeurMusicState();
}

class _ContributeurMusicState extends State<ContributeurMusic> {
  String fonttitle = FontsTitle;
  String font = Fonts;
  List<ModelMusic> listModel = [];
  PlaylistMusic playlist;
  List allData = [];
  List data = [];
  List allDataFilter = [];
  Future notFilter;
  String con;
  String rank;

  var futureBuild;

  Future getData() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection('Music').get();

    qn.docs.forEach((element) {
      if (element.data()['contributeur'] == con) {
        ModelMusicFirebase model = ModelMusicFirebase.fromMap(element.data());
        data.add(model);
      }
    });

    setState(() {
      allData = data;
      allDataFilter = allData;
    });
    return 'Complete';
  }

  void initState() {
    rank = widget.rank;
    con = widget.con;
    futureBuild = getData();
    searchController.addListener(searchFunction);
    super.initState();
  }

  searchFunction() {
    List m = [];
    if (searchController.text.isEmpty) {
      m = allData;
    } else {
      for (ModelMusicFirebase model in allData) {
        if (model.titre
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) ||
            model.artiste
                .toLowerCase()
                .contains(searchController.text.toLowerCase())) {
          m.add(model);
        }
      }
    }
    setState(() {
      allDataFilter = m;
    });
  }

  @override
  void dispose() {
    searchController.removeListener(searchFunction);
    searchController.dispose();
    super.dispose();
  }

  Scaffold appBar() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.expand_more,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.purple[900],
        elevation: 0.0,
        centerTitle: true,
        title: Row(
          children: [
            Image.asset(
              rank,
              height: 40.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(con,
                style: TextStyle(
                    fontFamily: font,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3.0)),
          ],
        ),
      ),
      body: Container(
        decoration: linear(),
        child: Column(
          children: [
            searchWidget(),
            Expanded(
              child: listView(allDataFilter),
            ),
          ],
        ),
      ),
    );
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
              return Container(
                child: appBar(),
              );
            }
          }),
    );
  }

  Container listView(List snapshot) {
    return Container(
      child: ListView.builder(
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
            child: Card(
              color: Colors.grey[900].withOpacity(0),
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Stack(children: [
                        Image.asset(
                          snapshot[index].image,
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
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot[index].titre,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontFamily: fonttitle,
                              ),
                            ),
                            //SizedBox(height: 7.0),
                            Text(snapshot[index].artiste,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white60,
                                    fontFamily: font)),
                            SizedBox(
                              height: 9.0,
                            ),
                            Text(snapshot[index].time,
                                style: TextStyle(
                                    color: Colors.white30, fontSize: 10.0)),
                          ],
                        ),
                      ),
                    ),
                    popMenu(allData, index)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Column popMenu(List snapshot, int index) {
    return Column(children: [
      PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.white60,
        ),
        color: Colors.purple[100],
        onSelected: (choice) {
          if (choice == Constants.ecouter) {
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
          } else if (choice == Constants.telecharger) {
            var model = ModelMusic(
              titre: snapshot[index].titre,
              artiste: snapshot[index].artiste,
              url: snapshot[index].url,
              size: snapshot[index].size,
              time: snapshot[index].time,
              image: snapshot[index].image,
              contributeur: snapshot[index].contributeur,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Download(model: model),
              ),
            );
          } else if (choice == Constants.partager) {
            print('SignOut');
          }
        },
        itemBuilder: (context) {
          return Constants.choices
              .map((String e) => PopupMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList();
        },
      ),
      Row(
        children: [
          Text(snapshot[index].size,
              style: TextStyle(color: Colors.white30, fontSize: 10.0)),
        ],
      )
    ]);
  }

  Card searchWidget() {
    return Card(
      elevation: 24.0,
      color: Colors.purple[800],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            prefixIcon:
                Icon(Icons.search_outlined, size: 30, color: Colors.white70),
            hintText: 'Titre ou artiste...',
            hintStyle: TextStyle(color: Colors.white30),
          ),
        ),
      ),
    );
  }
}
