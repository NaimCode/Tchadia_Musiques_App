import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:music_app3/constante/colors.dart';
import 'package:music_app3/constante/model.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class Download extends StatefulWidget {
  ModelMusic model;
  Download({this.model});
  @override
  _DownloadState createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  double progressSize = 0.0;
  ModelMusic model;
  bool downloadComplete = false;
  bool download = false;
  String progress = '';
  String progressComplete = 'En téléchargement...';
  Future dowloadFle() async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      String pathMusic = '${dir.path}/music/${model.titre}.mp3';
      print(pathMusic);
      await dio.download(
        model.url,
        pathMusic,
        onReceiveProgress: (rec, total) {
          print("rec=$rec,total=$total");
          setState(() {
            progressSize = ((rec / total) * 100);
            progress = progressSize.toStringAsFixed(0) + "%";
            download = true;
          });
        },
      );
    } catch (e) {
      print(e);
      setState(() {
        download = false;
      });
    }
    setState(() {
      progress = '100%';
      progressComplete = 'Téléchargement terminé';
      downloadComplete = true;
    });
  }

  Widget circleprogressfunction() {
    return CircularProgressIndicator(
        value: (progressSize / 100), //progressSize,
        strokeWidth: 8.0);
  }

  @override
  void initState() {
    model = widget.model;
    dowloadFle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!download) {
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
              Text('Chargement...', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ));
    } else {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.purple[900],
          leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: downloadComplete
                ? Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )
                : Container(),
          ),
        ),
        body: WillPopScope(
          onWillPop: () {
            //ShowaSneekBar
            if (downloadComplete) {
              Navigator.pop(context);
            }
          },
          child: Container(
            width: double.infinity,
            // height: double.infinity,
            decoration: linear(),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    width: double.infinity,
                    child: Card(
                      elevation: 20.0,
                      color: Colors.purple[800],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              model.titre,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 30.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              model.artiste,
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 150.0,
                            width: 150.0,
                            child: circleprogressfunction(),
                          ),
                          SizedBox(
                            height: 60.0,
                          ),
                          Text(
                            progress,
                            style: TextStyle(
                                color: Colors.white70, fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            progressComplete,
                            style: TextStyle(
                                color: Colors.white70, fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
