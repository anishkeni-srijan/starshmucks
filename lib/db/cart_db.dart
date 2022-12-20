import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '/model/cart_model.dart';

class CartDB {
  Future<Database> initDBCart() async {
    String databasepath = await getDatabasesPath();
    final path = join(databasepath, "Cart.db");
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE IF NOT EXISTS CartTable(
          id INT NOT NULL UNIQUE,
          qty INT NOT NULL
          )
          """);
      },
      version: 1,
    );
  }

  Future<bool> insertDataCart(CartModel item) async {
    final Database db = await initDBCart();
    int count = await db.insert("CartTable", item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);

    if (count > 0) {
    } else {
      final List<Map<String, dynamic>> maps =
          await db.query("CartTable", where: 'id = ?', whereArgs: [item.id]);
      var test = CartModel(id: maps[0]['id'], qty: maps[0]['qty']);
      increseqty(test);
    }
    return true;
  }

  Future<List<CartModel>> getDataCart() async {
    final Database db = await initDBCart();
    final List<Map<String, dynamic>> data = await db.query("CartTable");

    return data.map((e) => CartModel.fromJson(e)).toList();
  }

  clear() async {
    final Database db = await initDBCart();
    db.delete("CartTable");
  }

  Future<void> deleteitem(CartModel cartitem) async {
    final db = await initDBCart();
    await db.delete('CartTable', where: 'id = ?', whereArgs: [cartitem.id]);
  }

  increseqty(CartModel cartitem) async {
    var fido = CartModel(id: cartitem.id, qty: cartitem.qty + 1);
    updateqty(fido);
  }

  decreaseqty(CartModel cartitem) async {
    var fido = CartModel(id: cartitem.id, qty: cartitem.qty - 1);
    updateqty(fido);
  }

  Future<void> updateqty(CartModel cartitem) async {
    final db = await initDBCart();
    await db.update('CartTable', cartitem.toMap(),
        where: 'id = ?', whereArgs: [cartitem.id]);
  }
}
