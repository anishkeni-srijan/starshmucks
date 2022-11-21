import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:starshmucks/model/cartDBModel.dart';
import 'menu_db.dart';

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
    return true;
  }

  Future<List<CartModel>> getDataCart() async {
    final Database db = await initDBCart();
    final List<Map<String, dynamic?>> data = await db.query("CartTable");
    //print("after query");
    return data.map((e) => CartModel.fromJson(e)).toList();
  }
}
