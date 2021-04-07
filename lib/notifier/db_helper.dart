import 'package:flutter/services.dart';
import 'package:music_app3/constante/model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Importing 'package:flutter/widgets.dart' is required.
class DataBase {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "tchadia.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Music(titre TEXT, artiste TEXT, music_path TEXT, music_size TEXT, music_time TEXT, music_image TEXT, contributeur TEXT)");
    await db.execute("CREATE TABLE User(nom TEXT, theme TEXT, image TEXT)");
    print("Created tables User");
    print("Created tables");
  }

  Future getUser() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM User');
    Utilisateur user;
    try {
      user.nom = list[0]["nom"];
      user.theme = list[0]["theme"];
      user.image = list[0]["image"];
      return user;
    } catch (e) {
      user.nom = 'Annonyme';
      user.theme = 'default';
      user.image = '';
      return user;
    }
  }

// Retrieving employees from Employee Tables
  Future getEmployees() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Music');
    List<ModelMusic> musicList = new List();
    for (int i = 0; i < list.length; i++) {
      musicList.add(new ModelMusic(
        titre: list[i]["titre"],
        artiste: list[i]["artiste"],
        url: list[i]["music_path"],
        size: list[i]["music_size"],
        time: list[i]["music_time"],
        image: list[i]["music_image"],
        contributeur: list[i]["contributeur"],
      ));
    }
    print(musicList.length);
    return musicList;
  }

  void saveEmployee(ModelMusic model) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO Music(titre, artiste, music_path, music_size, music_time, music_image, contributeur) VALUES(' +
              '\'' +
              model.titre +
              '\'' +
              ',' +
              '\'' +
              model.artiste +
              '\'' +
              ',' +
              '\'' +
              model.url +
              '\'' +
              ',' +
              '\'' +
              model.size +
              '\'' +
              ',' +
              '\'' +
              model.time +
              '\'' +
              ',' +
              '\'' +
              model.image +
              '\'' +
              ',' +
              '\'' +
              model.contributeur +
              '\'' +
              ')');
    });
  }

  delete(ModelMusic model) async {
    var dbClient = await db;
    await dbClient
        .rawDelete('DELETE FROM Music WHERE titre = ?', [model.titre]);
  }

  void saveUser(Utilisateur user) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert('INSERT INTO User(nom,theme,image) VALUES(' +
          '\'' +
          user.nom +
          '\'' +
          ',' +
          '\'' +
          user.theme +
          '\'' +
          ',' +
          '\'' +
          user.image +
          '\'' +
          ')');
    });
  }
}

class SharedPref {
  setSharedPref(String key, String type, var nom) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (type == 'String') {
      prefs.setString(key, nom);
    } else {
      if (type == 'int') {
        prefs.setInt(key, nom);
      } else {
        if (type == 'bool') {
          prefs.setBool(key, nom);
        } else {
          if (type == 'double') {
            prefs.setDouble(key, nom);
          }
        }
      }
    }
  }

  getSharedPrefString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nom = prefs.getString(key) ?? "";
    return nom;
    // } else {
    //   if (type == 'int') {
    //     return prefs.getInt(key);
    //   } else {
    //     if (type == 'bool') {
    //       return prefs.getBool(key);
    //     } else {
    //       if (type == 'double') {
    //         return prefs.getDouble(key);
    //       }
    //     }
    //   }
    // }
  }
}
