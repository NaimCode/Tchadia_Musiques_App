import 'package:music_app3/constante/model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';

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
    String path = join(documentsDirectory.path, "test.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Music(titre TEXT, artiste TEXT, music_path TEXT, music_size TEXT )");
    print("Created tables");
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
          size: list[i]["music_size"]));
    }
    print(musicList.length);
    return musicList;
  }

  void saveEmployee(ModelMusic model) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO Music(titre, artiste, music_path, music_size ) VALUES(' +
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
              ')');
    });
  }

  delete(ModelMusic model) async {
    var dbClient = await db;
    await dbClient
        .rawDelete('DELETE FROM Music WHERE titre = ?', [model.titre]);
  }
}
