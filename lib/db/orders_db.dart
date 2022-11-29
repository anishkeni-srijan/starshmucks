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
           qty TEXT NOT NULL,
           rewards TEXT NOT NULL
          )
          """);
      },
      version: 1,
    );
  }

  createarr(idarr, qtyarr) async {
    var fido = await OrderHistoryModel(
      rewards: null,
      id: idarr,
      qty: qtyarr,
    );
    insertDataOrders(fido);
  }

  Future<bool> insertDataOrders(OrderHistoryModel fido) async {
    final Database db = await initDBOrders();
    db.insert("OrdersTable", fido.toMap());
    //db.delete("OrdersTable");
    return true;
  }

  Future<List<OrderHistoryModel>> getDataOrders() async {
    final Database db = await initDBOrders();
    final List<Map<String, dynamic?>> data = await db.query("OrdersTable");
    return data.map((e) => OrderHistoryModel.fromJson(e)).toList();
  }

  Future<List<OrderHistoryModel>> getDataOrderswrtID(id) async {
    final Database db = await initDBOrders();
    final List<Map<String, dynamic?>> data =
        await db.query("OrdersTable", where: 'orderid = ?', whereArgs: [id]);
    return data.map((e) => OrderHistoryModel.fromJson(e)).toList();
  }

  Future<dynamic> getOrderId() async {
    final Database db = await initDBOrders();
    final List<Map<String, dynamic?>> data = await db.rawQuery("Select orderid FROM OrdersTable ORDER BY column DESC LIMIT 1");
    print(data);
    return data.asMap();
  }
  Future<dynamic> getalldata() async{
    final Database db = await initDBOrders();
    final List<Map<String, dynamic?>> data = await db.rawQuery("Select * from OrdersTable");
    return data.asMap();
  }
  gainrewards(OrderHistoryModel cartitem) async {
    final db = await initDBOrders();
    var fido = OrderHistoryModel(
      qty:cartitem.qty ,
      id:cartitem.id,
      rewards:'30',
    );
    updateqty(fido);
  }

  Future<void> updateqty(OrderHistoryModel cartitem) async {
    // Get a reference to the database.
    final db = await initDBOrders();
    // Update the given Dog.
    await db.update(
      'CartTable', cartitem.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'orderid = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [cartitem.id],
    );
  }

}
