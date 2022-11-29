import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '/model/address_model.dart';
import '/model/user_model_new.dart';

class UserDB {
  //user Data
  Future<Database> initDBUserData() async {
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
          rewards DOUBLE NOT NULL,
          FOREIGN KEY (id) REFERENCES UserAddress(userID)
       )
          """);
//address table
        await database.execute("""
          CREATE TABLE IF NOT EXISTS UserAddress(
          addressID INTEGER PRIMARY KEY AUTOINCREMENT,
          userID INTEGER NOT NULL,
          fname TEXT NOT NULL,
          phone TEXT NOT NULL,
          hno TEXT NOT NULL,
          road TEXT NOT NULL,
          city TEXT NOT NULL,
          state TEXT NOT NULL,
          pincode TEXT NOT NULL
          )
          """);
      },

      // onConfigure: _onConfigure,
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
    //print("Getting user data");
    //print(data[0]['email']);
    return data;
  }

  Future<bool> insertUserAddress(AddressModel address) async {
    final Database db = await initDBUserData();
    db.insert("UserAddress", address.toMap());
    print("Added address");
    return true;
  }

  Future<List<AddressModel>> getDataUserAddress() async {
    //print("getting all usrs");
    final Database db = await initDBUserData();
    final List<Map<String, dynamic?>> data = await db.query("UserAddress");
    // print(data[1]["addressID"]);
    return data.map((e) => AddressModel.fromJson(e)).toList();
  }

  Future<List<Map<String, dynamic?>>> getDataUserAddress1() async {
    //print("getting all usrs");
    final Database db = await initDBUserData();
    final List<Map<String, dynamic?>> data = await db.query("UserAddress");
    // print(data[1]["addressID"]);
    return data;
  }

  Future<void> deleteitem(id) async {
    // Get a reference to the database.
    final db = await initDBUserData();

    // Remove the Dog from the database.
    await db.delete(
      "UserAddress",
      // Use a `where` clause to delete a specific dog.
      where: 'addressID = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> updateAddress(id, am) async {
    // Get a reference to the database.
    final db = await initDBUserData();

    // Update the given Dog.
    await db.update(
      "UserAddress", am.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'addressID = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
    print("updared");
  }
}
