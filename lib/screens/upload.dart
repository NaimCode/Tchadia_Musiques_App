import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:filesize/filesize.dart';

class Upload extends StatefulWidget {
  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Upload> {
  String fonttitle = FontsTitle;
  String font = Fonts;
  File music;
  var duration;
  String musicsize;
  String musicpath;
  // ignore: non_constant_identifier_names
  String music_down_url;
  bool loadingUpload = false;
  bool loadingSelectMusic = false;
  bool loadingMusicMini = false;
  final firestoreinstance = FirebaseFirestore.instance;
  void selectMusic() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      music = File(result.files.single.path);
      // Map info = (_flutterFFprobe.getMediaInformation(music.path)) as Map;
      // duration = (info['duration'] / 1000).round();

      musicsize = filesize(music.lengthSync());

      setState(() {
        loadingSelectMusic = true;
        music = music;

        musicpath = basename(music.path);
        uploadsongfile(music.readAsBytesSync(), musicpath);
      });
    }
  }

  // ignore: missing_return
  Future<String> uploadsongfile(List<int> song, String songpath) async {
    setState(() => loadingUpload = true);
    ref = FirebaseStorage.instance.ref().child(songpath);
    StorageUploadTask uploadTask = ref.putData(song);
    music_down_url = await (await uploadTask.onComplete).ref.getDownloadURL();

    setState(() {
      loadingUpload = false;
      loadingMusicMini = true;
    });
  }

  bool finalupload() {
    if (titreInput.text.toString().isNotEmpty &&
        artisteInput.text.toString().isNotEmpty &&
        music_down_url.toString() != null) {
      var data = {
        'titre': titreInput.text,
        'artiste': artisteInput.text,
        'music_url': music_down_url.toString(),
        'music_size': musicsize,
        // 'music_duration': duration,
      };

      firestoreinstance.collection('Music').doc().set(data);
      setState(() {
        titreInput.clear();
        artisteInput.clear();
        loadingMusicMini = false;
      });
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
                  'assets/image2.jpg',
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
                    FlatButton.icon(
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
                        ))
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
