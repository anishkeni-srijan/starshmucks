import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/nowserving_model.dart';

class NowServeDb {
  Future<Database> initNowServedb() async {
    print("initialising db... NS");
    String databasepath = await getDatabasesPath();
    final path = join(databasepath, "NowServe145.db");
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE IF NOT EXISTS NowServe(
          id INTEGER PRIMARY KEY,
          title TEXT NOT NULL,
          tag TEXT NOT NULL,
          desc TEXT NOT NULL,
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

  Future<bool> insertnowserveData(NowServe nowserve) async {
    final Database db = await initNowServedb();
    db.insert("NowServe", nowserve.toMap());
    return true;
  }

  Future<List<NowServe>> getnowservedata() async {
    final Database db = await initNowServedb();
    final List<Map<String, dynamic?>> data = await db.query("NowServe");
    return data.map((e) => NowServe.fromJson(e)).toList();
  }

  Future<List<NowServe>> NowServedata() async {
    final Database db = await initNowServedb();
    final List<Map<String, dynamic?>> nowserve = await db
        .rawQuery("SELECT * FROM NowServe WHERE category=?", ['nowserve']);
    return nowserve.map((e) => NowServe.fromJson(e)).toList();
  }
}
