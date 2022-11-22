import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/order_history.dart';

class OrdersDB {
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

  Future<bool> insertDataOrders(OrderHistoryModel orders) async {
    final Database db = await initDBOrders();
    db.insert("OrdersTable", orders.toMap());
    return true;
  }

  Future<List<OrderHistoryModel>> getDataOrders() async {
    final Database db = await initDBOrders();
    final List<Map<String, dynamic?>> data = await db.query("OrdersTable");
    return data.map((e) => OrderHistoryModel.fromJson(e)).toList();
  }
}
