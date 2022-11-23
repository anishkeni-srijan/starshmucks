import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/menu_model.dart';

class MenuDB {
  Future<Database> initDBMenu() async {
    //print("initialising db... menu");
    String databasepath = await getDatabasesPath();
    final path = join(databasepath, "Menu2.db");
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
          tag TEXT NOT NULL,
          category TEXT NOT NULL
          )
          """);
      },
      version: 1,
    );
  }

  Future<bool> insertDataMenu(MenuModel menu) async {
    final Database db = await initDBMenu();
    int count = 0;
    db.insert("Menu", menu.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    return true;
  }

  Future<List<MenuModel>> getDataMenu() async {
    final Database db = await initDBMenu();
    final List<Map<String, dynamic?>> data = await db.query("Menu");
    return data.map((e) => MenuModel.fromJson(e)).toList();
  }

  Future<List<MenuModel>> coffeedata() async {
    final Database db = await initDBMenu();
    final List<Map<String, dynamic?>> coffee =
        await db.rawQuery("SELECT * FROM Menu WHERE category=?", ['coffee']);
    return coffee.map((e) => MenuModel.fromJson(e)).toList();
  }

  Future<List<MenuModel>> cakedata() async {
    final Database db = await initDBMenu();
    final List<Map<String, dynamic?>> cake =
        await db.rawQuery("SELECT * FROM Menu WHERE category=?", ['cake']);
    return cake.map((e) => MenuModel.fromJson(e)).toList();
  }

  Future<List<MenuModel>> smoothiedata() async {
    final Database db = await initDBMenu();
    final List<Map<String, dynamic?>> data =
        await db.rawQuery("SELECT * FROM Menu WHERE category=?", ['smoothie']);
    return data.map((e) => MenuModel.fromJson(e)).toList();
  }

  Future<List<MenuModel>> NowServedata() async {
    final Database db = await initDBMenu();
    final List<Map<String, dynamic?>> nowserve =
        await db.rawQuery("SELECT * FROM Menu WHERE category=?", ['nowserve']);
    return nowserve.map((e) => MenuModel.fromJson(e)).toList();
  }

  Future<List<MenuModel>> Offersdata() async {
    final Database db = await initDBMenu();
    final List<Map<String, dynamic>> offerlist =
        await db.rawQuery("SELECT * FROM Menu WHERE category=?", ['offers']);
    return offerlist.map((e) => MenuModel.fromJson(e)).toList();
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<MenuModel>> getElementOnId_Menu(getit) async {
    final db = await initDBMenu();
    final List<Map<String, dynamic>> maps =
        await db.query('Menu', where: "id = ?", whereArgs: [getit]);
    return List.generate(maps.length, (i) {
      return MenuModel(
        id: maps[i]['id'],
        tag: maps[i]['tag'],
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
