import 'package:flutter/material.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:music_app3/constante/model.dart';
import 'package:music_app3/screens/download.dart';
import 'package:music_app3/screens/index.dart';
import 'package:music_app3/screens/music.dart';
import 'package:music_app3/screens/music.dart';

class ArtistMusic extends StatefulWidget {
  List listmusic;

  ArtistMusic(this.listmusic);
  @override
  _ArtistMusicState createState() => _ArtistMusicState();
}

class _ArtistMusicState extends State<ArtistMusic> {
  List<ModelMusic> listModel = [];
  String fonttitle = FontsTitle;
  String font = Fonts;
  List listmusic;
  PlaylistMusic playlist;
  String artiste;
  @override
  void initState() {
    listmusic = widget.listmusic;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        elevation: 10.0,
        centerTitle: true,
        title: Text(listmusic[0].artiste,
            style: TextStyle(
              fontFamily: fonttitle,
              fontWeight: FontWeight.bold,
              letterSpacing: 3.0,
            )),
      ),
      body: Container(
        child: Column(
          children: [
            Image.asset('assets/artisteList.jpg'),
            Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Titres',
                style: TextStyle(fontSize: 30.0, fontFamily: font),
              ),
            ),
            Expanded(child: listView(listmusic)),
          ],
        ),
      ),
    );
  }

  Container listView(List snapshot) {
    return Container(
      child: ListView.builder(
        itemCount: listmusic.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              listModel.clear();
              for (var model in listmusic) {
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
              color: Colors.grey[900].withOpacity(1),
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
                    popMenu(listmusic, index)
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
            for (var model in listmusic) {
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
}
