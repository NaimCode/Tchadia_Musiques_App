import 'package:just_audio/just_audio.dart';

class ModelMusic {
  String artiste, titre, url, size, time, contributeur, image;
  ModelMusic(
      {this.artiste,
      this.size,
      this.titre,
      this.url,
      this.time,
      this.image,
      this.contributeur});
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
  String artiste, titre, url, size, time, contributeur, image;
  ModelMusicFirebase.fromMap(Map<String, dynamic> data) {
    artiste = data['artiste'];
    titre = data['titre'];
    url = data['music_url'];
    size = data['music_size'];
    time = data['music_timer'];
    contributeur = data['contributeur'];
    image = data['image_url'];
  }
}

class Utilisateur {
  String nom, image, theme, email, uid;
  bool admin;
  List<String> follower, following;
  Utilisateur(
      {this.nom,
      this.theme,
      this.image,
      this.email,
      this.admin,
      this.uid,
      this.follower,
      this.following});
}

class Contributeur {
  String username;
  int numMusic;
  Contributeur({this.username, this.numMusic});
}
