import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '/model/address_model.dart';
import '/model/user_model_new.dart';

class UserDB {
  //user Data
  Future<Database> initDBUserData() async {
    print("initialising db... user data");
    String databasepath = await getDatabasesPath();
    final path = join(databasepath, "User.db");
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE IF NOT EXISTS UserData(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT NOT NULL,
          phone TEXT NOT NULL,
          dob TEXT NOT NULL,
          password TEXT NOT NULL,
          tnc TEXT NOT NULL,
          rewards DOUBLE NOT NULL
          )
          """);
      },
      version: 1,
    );
  }

  Future<bool> insertUserData(UserModel user) async {
    final Database db = await initDBUserData();
    db.insert("UserData", user.toMap());
    print("Inserting user" + user.email);
    return true;
  }

  Future<List<Map<String, dynamic>>> getDataUserData() async {
    final Database db = await initDBUserData();
    final List<Map<String, dynamic?>> data = await db.query("UserData");
    print("Getting user data");
    print(data[0]['email']);
    return data;
  }

  //user address
  Future<Database> initDBUserAddress() async {
    print("initialising db... user address");
    String databasepath = await getDatabasesPath();
    final path = join(databasepath, "User.db");
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE IF NOT EXISTS UserAddress(
          addressID INTEGER PRIMARY KEY AUTOINCREMENT,
          userID INTEGER NOT NULL references UserData(id),
          address TEXT 
          )
          """);
      },
      version: 1,
    );
  }

  Future<bool> insertUserAddress(AddressModel address) async {
    final Database db = await initDBUserAddress();
    db.insert("UserAddress", address.toMap());
    return true;
  }

  Future<List<AddressModel>> getDataUserAddress() async {
    final Database db = await initDBUserAddress();
    final List<Map<String, dynamic?>> data = await db.query("UserAddress");
    return data.map((e) => AddressModel.fromJson(e)).toList();
  }
}
