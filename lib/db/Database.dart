import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/menu_model.dart';

class DB {


  Future<Database> initDB() async {
    print("initialising db...");
    String databasepath = await getDatabasesPath();
    final path = join(databasepath, "MenuTable.db");
    return openDatabase(path,
      onCreate: (database, version) async {
        await database.execute(
            """
          CREATE TABLE IF NOT EXISTS Menu(
          id INTEGER PRIMARY KEY,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          image TEXT NOT NULL,
          rating TEXT NOT NULL,
          price TEXT NOT NULL
          
          )
          """
        );
      },
      version: 1,
    );
  }
  Future<bool> insertData(Menu menuitem) async{
    final Database db = await initDB();
    db.insert("Menu", menuitem.toMap());
    return true;
  }

  Future<List<Menu>> getdata() async{
    final Database db = await initDB();
    final List<Map<String,dynamic?>> data = await db.query("Menu");
    return data.map((e) => Menu.fromJson(e)).toList();
  }

}



