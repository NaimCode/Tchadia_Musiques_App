import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:music_app3/constante/model.dart';

class MusicNotifier with ChangeNotifier {
  List<ModelMusicFirebase> ListMusic = [];
  ModelMusicFirebase currentMusic;
  UnmodifiableListView<ModelMusicFirebase> get getListMusic =>
      UnmodifiableListView(ListMusic);
}
