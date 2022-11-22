import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:starshmucks/model/orderHistory.dart';

import '../model/menu_model.dart';

class MenuDB {
  Future<Database> initDBMenu() async {
    print("initialising db...");
    String databasepath = await getDatabasesPath();
    final path = join(databasepath, "Menutable.db");
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE IF NOT EXISTS Menu(
          id INTEGER PRIMARY KEY,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          image TEXT NOT NULL,
          rating TEXT NOT NULL,
          price TEXT NOT NULL,
          category TEXT NOT NULL
          )
          """);
      },
      version: 1,
    );
  }

  Future<bool> insertDataMenu(Menu menu) async {
    final Database db = await initDBMenu();
    db.insert("Menu", menu.toMap());
    return true;
  }

  Future<List<Menu>> getDataMenu() async {
    final Database db = await initDBMenu();
    final List<Map<String, dynamic?>> data = await db.query("Menu");
    return data.map((e) => Menu.fromJson(e)).toList();
  }

  Future<List<Menu>> coffeedata() async {
    final Database db = await initDBMenu();
    final List<Map<String, dynamic?>> coffee =
        await db.rawQuery("SELECT * FROM Menu WHERE category=?", ['coffee']);
    return coffee.map((e) => Menu.fromJson(e)).toList();
  }

  Future<List<Menu>> cakedata() async {
    final Database db = await initDBMenu();
    final List<Map<String, dynamic?>> cake =
        await db.rawQuery("SELECT * FROM Menu WHERE category=?", ['cake']);
    return cake.map((e) => Menu.fromJson(e)).toList();
  }

  Future<List<Menu>> smoothiedata() async {
    final Database db = await initDBMenu();
    final List<Map<String, dynamic?>> data =
        await db.rawQuery("SELECT * FROM Menu WHERE category=?", ['smoothie']);
    return data.map((e) => Menu.fromJson(e)).toList();
  }

  ffeedata(getid) async {
    final Database db = await initDBMenu();
    dynamic data =
        await db.query("Menu", where: "id = ?", whereArgs: [getid]) as Menu;
    print(data.runtimeType);
    return data;
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Menu>> fefe(getit) async {
    final db = await initDBMenu();
    final List<Map<String, dynamic>> maps =
        await db.query('Menu', where: "id = ?", whereArgs: [getit]);
    return List.generate(maps.length, (i) {
      return Menu(
        id: maps[i]['id'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        description: maps[i]['description'],
        category: maps[i]['category'],
        image: maps[i]['image'],
        rating: maps[i]['rating'],
      );
    });
  }
}
