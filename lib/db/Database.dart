import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/menu_model.dart';

class DB{
  Future<Database> initDb() async {
    String databasepath = await getDatabasesPath();
    final path = join(databasepath, "menu.db");
    return openDatabase(path,
      onCreate: (databse, version) async {
      await databse.execute(
          """
          CREATE TABLE MENU(
          id INTEGER PRIMARY KEY,
          title TEXT NOT NULL,
          SUBTITLE TEXT NOT NULL
          )
          """);
      },
      version: 1,
    );
  }

  Future<bool> insert(Menu menu,context) async{
    final Database db = await initDb();
    final String response = await DefaultAssetBundle.of(context).loadString("json/menu.json");
    Map<String, dynamic> decodedData = jsonDecode(response);

    for(Map<String, dynamic> menuMap in decodedData['products']){
      db.insert('Menu', menuMap);
    }

    return true;
  }
}
