import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:music_app3/constante/model.dart';
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
  List<ModelMusic> listModel = [];
  PlaylistMusic playlist;
  String imageAlbum = 'assets/album1.PNG';
  String image = 'assets/BackEqaliseur.jpg';
  Future getData() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection('Music').get();

    return qn.docs;
  }

  void choiceAction(String choice) {
    if (choice == Constants.ecouter) {
      print('Settings');
    } else if (choice == Constants.telecharger) {
      print('Subscribe');
    } else if (choice == Constants.partager) {
      print('SignOut');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        elevation: 10.0,
        title: Text('Musiques'),
        centerTitle: true,
      ),
      body: Container(
        decoration: linear(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 10.0,
              // backgroundColor: theme.primary,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: SliverFixedExtentList(
                itemExtent: 500,
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      child: FutureBuilder(
                          future: getData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    ModelMusic model = ModelMusic(
                                      titre:
                                          snapshot.data[index].data()['titre'],
                                      artiste: snapshot.data[index]
                                          .data()['artiste'],
                                      url: snapshot.data[index]
                                          .data()['music_url'],
                                      size: snapshot.data[index]
                                          .data()['music_size'],
                                    );
                                    listModel.add(model);

                                    return InkWell(
                                      onTap: () {
                                        playlist = PlaylistMusic(
                                            listmodel: listModel, index: index);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MusicPlayerPage(
                                                    playlist: playlist),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        color: Colors.grey[900].withOpacity(0),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.0, right: 3.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 1,
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
                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        snapshot.data[index]
                                                            .data()['titre'],
                                                        style: TextStyle(
                                                            fontSize: 18.0,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      //SizedBox(height: 7.0),
                                                      Text(
                                                          snapshot.data[index]
                                                                  .data()[
                                                              'artiste'],
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              color: Colors
                                                                  .white60)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Column(children: [
                                                PopupMenuButton(
                                                  icon: Icon(
                                                    Icons.more_vert,
                                                    color: Colors.white60,
                                                  ),
                                                  color: Colors.purple,
                                                  onSelected: choiceAction,
                                                  itemBuilder: (context) {
                                                    return Constants.choices
                                                        .map((String e) =>
                                                            PopupMenuItem(
                                                              value: e,
                                                              child: Text(e),
                                                            ))
                                                        .toList();
                                                  },
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                        snapshot.data[index]
                                                                .data()[
                                                            'music_size'],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white30,
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
                          }),
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
