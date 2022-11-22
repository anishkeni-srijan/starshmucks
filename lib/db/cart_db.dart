import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '/model/cart_model.dart';

class CartDB {
  Future<Database> initDBCart() async {
    print("initialising db Cart");
    String databasepath = await getDatabasesPath();
    final path = join(databasepath, "Cart.db");
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE IF NOT EXISTS CartTable(
          id INT NOT NULL
          )
          """);
      },
      version: 1,
    );
  }

  Future<bool> insertDataCart(CartModel item) async {
    // print("inserting in cart");
    final Database db = await initDBCart();
    db.insert("CartTable", item.toMap());
    //db.delete("CartTable");
    return true;
  }

  Future<List<CartModel>> getDataCart() async {
    final Database db = await initDBCart();
    final List<Map<String, dynamic?>> data = await db.query("CartTable");
    print("after query");
    print(data.length);
    return data.map((e) => CartModel.fromJson(e)).toList();
  }

  //temp
  clear() async {
    final Database db = await initDBCart();
    db.delete("CartTable");
  }
  Future<void> deleteitem(int id) async {
    // Get a reference to the database.
    final db = await initDBCart();

    // Remove the Dog from the database.
    await db.delete(
      'CartTable',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

}
