import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/order_history.dart';

class OrdersDB {
  Future<Database> initDBOrders() async {
    String databasepath = await getDatabasesPath();
    final path = join(databasepath, "Orders.db");
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE IF NOT EXISTS OrdersTable(
           orderid INTEGER PRIMARY KEY AUTOINCREMENT,
           id TEXT NOT NULL,
           qty TEXT NOT NULL,
           date TEXT NOT NULL,
           time TEXT NOT NULL        )
          """);
      },
      version: 1,
    );
  }

  createarr(idarr, qtyarr, date, time) async {
    var fido = OrderHistoryModel(
      id: idarr,
      qty: qtyarr,
      date: date,
      time: time,
    );
    insertDataOrders(fido);
  }

  Future<bool> insertDataOrders(OrderHistoryModel fido) async {
    final Database db = await initDBOrders();
    db.insert("OrdersTable", fido.toMap());
    return true;
  }

  Future<List<OrderHistoryModel>> getDataOrders() async {
    final Database db = await initDBOrders();
    final List<Map<String, dynamic>> data = await db.query("OrdersTable");
    return data.map((e) => OrderHistoryModel.fromJson(e)).toList();
  }

  Future<List<OrderHistoryModel>> getDataOrderswrtID(id) async {
    final Database db = await initDBOrders();
    final List<Map<String, dynamic>> data =
        await db.query("OrdersTable", where: 'orderid = ?', whereArgs: [id]);
    return data.map((e) => OrderHistoryModel.fromJson(e)).toList();
  }

  Future<dynamic> getalldata() async {
    final Database db = await initDBOrders();
    final List<Map<String, dynamic>> data =
        await db.rawQuery("Select * from OrdersTable");
    return data.asMap();
  }
// gainrewards(OrderHistoryModel cartitem,res) async {
//   final db = await initDBOrders();
//   var fido = OrderHistoryModel(
//     rewards:res,
//     qty: cartitem.qty,
//     id: cartitem.id,
//   );
//   updaterewards(fido);
// }
// //
// Future<void> updaterewards(OrderHistoryModel cartitem) async {
//   // Get a reference to the database.
//   final db = await initDBOrders();
//   // Update the given Dog.
//   await db.update(
//     'CartTable', cartitem.toMap(),
//     // Ensure that the Dog has a matching id.
//     where: 'id= ?',
//     // Pass the Dog's id as a whereArg to prevent SQL injection.
//     whereArgs: [cartitem.id],
//   );
// }

}
