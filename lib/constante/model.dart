import 'package:just_audio/just_audio.dart';

class ModelMusic {
  String artiste, titre, url, size;
  ModelMusic({this.artiste, this.size, this.titre, this.url});
}

class PlaylistMusic {
  List<ModelMusic> listmodel;
  int index;
  PlaylistMusic({this.index, this.listmodel});
}

class Playback {
  String titre;
  AudioPlayer player;
  Playback({this.titre, this.player});
}

class ModelMusicFirebase {
  String artiste, titre, url, size;
  ModelMusicFirebase.fromMap(Map<String, dynamic> data) {
    artiste = data['artiste'];
    titre = data['titre'];
    url = data['music_url'];
    size = data['music_size'];
  }
}
