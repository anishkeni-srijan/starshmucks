import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:starshmucks/model/cart_model.dart';
import 'package:starshmucks/model/orderHistory.dart';

import '../model/menu_model.dart';

class DB {
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

  //Orders DB
  Future<Database> initDBOrders() async {
    print("initialising db orders");
    String databasepath = await getDatabasesPath();
    final path = join(databasepath, "Orders.db");
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE IF NOT EXISTS OrdersTable(
          id INTEGER PRIMARY KEY,
          title TEXT NOT NULL,
          price TEXT NOT NULL,
          qty INT NOT NULL,
          isInCart BOOLEAN NOT NULL,
          image TEXT NOT NULL,
          ttlPrice DOUBLE NOT NULL
          )
          """);
      },
      version: 1,
    );
  }

  Future<bool> insertDataOrders(OrderHistory orders) async {
    final Database db = await initDBOrders();
    db.insert("OrdersTable", orders.toMap());
    return true;
  }

  Future<List<OrderHistory>> getDataOrders() async {
    final Database db = await initDBOrders();
    final List<Map<String, dynamic?>> data = await db.query("OrdersTable");
    return data.map((e) => OrderHistory.fromJson(e)).toList();
  }
}
