import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:filesize/filesize.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Upload extends StatefulWidget {
  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Upload> {
  StorageUploadTask uploadTask;
  final player = AudioPlayer();
  String contributeur = 'Inconnu';
  String fonttitle = FontsTitle;
  String font = Fonts;
  File music;
  var duration, musicTimer;
  String musicsize;
  String musicpath;

  // ignore: non_constant_identifier_names
  String music_down_url;
  bool loadingUpload = false;
  bool loadingSelectMusic = false;
  bool loadingMusicMini = false;
  final firestoreinstance = FirebaseFirestore.instance;
  void selectMusic() async {
    setState(() {
      loadingSelectMusic = true;
    });
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      music = File(result.files.single.path);
      // Map info = (_flutterFFprobe.getMediaInformation(music.path)) as Map;
      // duration = (info['duration'] / 1000).round();

      musicsize = filesize(music.lengthSync());
      musicpath = basename(music.path);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      contributeur = prefs.getString('Nom') ?? 'Inconnu';
      uploadsongfile(music.readAsBytesSync(), musicpath, music.path);
    } else {
      setState(() async {
        loadingSelectMusic = false;
      });
    }
  }

  format(Duration d) => d.toString().substring(2, 7);
  // ignore: missing_return
  Future<String> uploadsongfile(
      List<int> song, String songpath, String path) async {
    setState(() => loadingUpload = true);
    ref = FirebaseStorage.instance.ref().child(songpath);
    uploadTask = ref.putData(song);
    music_down_url = await (await uploadTask.onComplete).ref.getDownloadURL();
    musicTimer = format(await player.setUrl(path));
    setState(() {
      loadingUpload = false;
      loadingMusicMini = true;
    });
  }

  String randomImage() {
    List<String> listImage = [
      'assets/album/album1.PNG',
      'assets/album/album2.PNG',
      'assets/album/album3.PNG',
      'assets/album/album4.PNG',
      'assets/album/album5.PNG',
      'assets/album/album6.PNG',
      'assets/album/album7.PNG',
      'assets/album/album8.PNG',
      'assets/album/album9.PNG',
      'assets/album/album10.PNG',
      'assets/album/album11.PNG',
      'assets/album/album12.PNG',
      'assets/album/album13.PNG',
      'assets/album/album14.PNG',
      'assets/album/album15.PNG',
      'assets/album/album16.PNG',
      'assets/album/album17.PNG',
      'assets/album/album18.PNG',
      'assets/album/album19.PNG',
      'assets/album/album20.PNG',
      'assets/album/album21.PNG',
      'assets/album/album22.PNG',
      'assets/album/album23.PNG',
      'assets/album/album24.PNG',
      'assets/album/album25.PNG',
      'assets/album/album26.PNG',
      'assets/album/album27.PNG',
      'assets/album/album28.PNG',
      'assets/album/album29.PNG',
      'assets/album/album30.PNG',
    ];
    Random r = Random();
    return listImage[r.nextInt(listImage.length)];
  }

  bool finalupload() {
    if (titreInput.text.toString().isNotEmpty &&
        artisteInput.text.toString().isNotEmpty &&
        music_down_url.toString() != null) {
      var data = {
        'titre': titreInput.text,
        'artiste': artisteInput.text,
        'music_url': music_down_url.toString(),
        'image_url': randomImage(),
        'music_timer': musicTimer,
        'music_size': musicsize,
        'contributeur': contributeur,
        // 'music_duration': duration,
      };

      firestoreinstance.collection('Music').doc().set(data);
      setState(() {
        titreInput.clear();
        artisteInput.clear();
        loadingMusicMini = false;
      });
      // firestoreinstance.collection('Contributeur').doc('Naim');

      return true;
    } else {
      return false;
    }
  }

  final snackBar = SnackBar(
      content: Text(
    'La musique a été ajoutée',
    style: TextStyle(fontSize: 20.0, color: Colors.amber),
  ));
  final snackBarEchec = SnackBar(
      content: Text(
    'Erreur, verifiez que vous avez saisi tous les champs!',
    style: TextStyle(fontSize: 20.0, color: Colors.amber),
  ));
  StorageReference ref;
  TextEditingController titreInput = TextEditingController();
  TextEditingController artisteInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (loadingUpload == true) {
      return Scaffold(
          body: Container(
        decoration: linear(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitChasingDots(
                color: Colors.white,
                size: 90.0,
              ),
              SizedBox(
                height: 20,
              ),
              Text('Patientez s\'il vous plait...',
                  style: TextStyle(color: Colors.white)),
              SizedBox(
                height: 200,
              ),
              RaisedButton(
                onPressed: () {
                  uploadTask.cancel();
                  Navigator.pop(context);
                },
                child: Text(
                  'Annuler',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: font,
                      color: Colors.white,
                      letterSpacing: 3.0),
                ),
                color: Colors.red,
              )
            ],
          ),
        ),
      ));
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          elevation: 10.0,
          title: Text(
            'Ajout de musiques',
            style: TextStyle(
                fontFamily: fonttitle,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: linear(),
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  'assets/BackEqaliseur.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Veuillez remplir les champs suivants',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: titreInput,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        filled: true,
                        labelText: "Titre",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(
                            25.0,
                          ),
                        ),
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Veuillez saisir un titre";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: artisteInput,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        filled: true,
                        labelText: "Artiste",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(
                            25.0,
                          ),
                        ),
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Veuillez saisir un titre";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Text(
                      'Si vous ne connaissez pas le nom de l\'artiste,veuillez écrire "Inconnu" ',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlatButton.icon(
                          color: Colors.purple[900],
                          onPressed: () => selectMusic(),
                          icon: Icon(Icons.add, color: Colors.white),
                          label: Text(
                            'Choisir une musique',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        loadingMusicMini
                            ? Icon(
                                Icons.verified,
                                color: Colors.white,
                              )
                            : Icon(Icons.verified, color: Colors.white12)
                      ],
                    ),
                    Builder(builder: (BuildContext context) {
                      return FlatButton.icon(
                          color: Colors.amber,
                          onPressed: () {
                            bool ckeck = finalupload();
                            ckeck
                                ? Scaffold.of(context).showSnackBar(snackBar)
                                : Scaffold.of(context)
                                    .showSnackBar(snackBarEchec);
                          },
                          icon: Icon(
                            Icons.upload_file,
                          ),
                          label: Text(
                            'Ajouter la musique',
                            style: TextStyle(),
                          ));
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
