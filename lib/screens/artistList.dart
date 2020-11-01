import 'package:flutter/material.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:music_app3/constante/model.dart';
import 'package:music_app3/screens/allmusic.dart';
import 'package:music_app3/screens/artistmusic.dart';

class ArtistList extends StatefulWidget {
  List artistList;
  List musicList;
  ArtistList(this.artistList, this.musicList);
  @override
  _ArtistListState createState() => _ArtistListState();
}

class _ArtistListState extends State<ArtistList> {
  String fonttitle = FontsTitle;
  String font = Fonts;
  List musicList;
  List artistList = [];
  initState() {
    artistList = widget.artistList;
    musicList = widget.musicList;
    super.initState();
  }

  List artistMusic(String artiste) {
    List list = [];
    musicList.forEach((element) {
      if (element.artiste == artiste) {
        list.add(element);
      }
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        elevation: 10.0,
        title: Text('Artistes',
            style: TextStyle(
                fontFamily: fonttitle,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0)),
      ),
      body: Container(
        decoration: linear(),
        child: GridView.builder(
          itemCount: artistList.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ArtistMusic(artistMusic(artistList[index])),
                  ),
                );
              },
              child: Container(
                  //height: 100.0,
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: Card(
                      color: Colors.grey[900].withOpacity(0.0),
                      child: GridTile(
                        footer: Text(
                          artistList[index],
                          style: TextStyle(
                              fontFamily: font,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                        child: Image.asset(
                          'assets/artiste.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )),
            );
          },
        ),
      ),
    );
  }
}
