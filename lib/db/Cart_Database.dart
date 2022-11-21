import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/Cart_model.dart';

class CartDB {
  
  Future<Database> initDB() async {
    print("initialising db...");
    String databasepath = await getDatabasesPath();
    final path = join(databasepath, "Carttable.db");
    return openDatabase(path,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE IF NOT EXISTS Cart(
          id INTEGER PRIMARY KEY,
          )
          """);
      },
      version: 1,
    );
  }
  Future<bool> insertData(Cart cart) async{
    final Database db = await initDB();
    db.insert("Cart", cart.toMap());
    return true;
  }

  Future<List<Cart>> getdata() async{
    final Database db = await initDB();
    final List<Map<String,dynamic?>> data = await db.query("Cart");
    return data.map((e) => Cart.fromJson(e)).toList();
  }
  Future<List<Cart>> coffeedata() async{
    final Database db = await initDB();
    final List<Map<String,dynamic?>> coffee = await db.rawQuery("SELECT * FROM Cart WHERE category=?", ['coffee']);
    return coffee.map((e) => Cart.fromJson(e)).toList();
  }
  Future<List<Cart>> cakedata() async{
    final Database db = await initDB();
    final List<Map<String,dynamic?>> cake = await db.rawQuery("SELECT * FROM Cart WHERE category=?", ['cake']);
    return cake.map((e) => Cart.fromJson(e)).toList();
  }
  Future<List<Cart>> smoothiedata() async{
    final Database db = await initDB();
    final List<Map<String,dynamic?>> data = await db.rawQuery("SELECT * FROM Cart WHERE category=?", ['smoothie']);
    return data.map((e) => Cart.fromJson(e)).toList();
  }

}



