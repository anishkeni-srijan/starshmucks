import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
           qty TEXT NOT NULL
          )
          """);
      },
      version: 1,
    );
  }
  createarr(idarr,qtyarr)async{
    var fido = await OrderHistoryModel(
      id:idarr,
      qty:qtyarr,
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
    final List<Map<String, dynamic?>> data = await db.query("OrdersTable");
    return data.map((e) => OrderHistoryModel.fromJson(e)).toList();
  }
  Future<List<OrderHistoryModel>> getDataOrderswrtID(id) async {
    final Database db = await initDBOrders();
    final List<Map<String, dynamic?>> data = await db.query("OrdersTable", where: 'orderid = ?', whereArgs: [id]);
    return data.map((e) => OrderHistoryModel.fromJson(e)).toList();
  }
  Future<dynamic> getOrderId() async {
    final Database db = await initDBOrders();
    final List<Map<String, dynamic?>> data = await db.rawQuery("Select orderid from OrdersTable");
    return data.asMap();
  }

}
