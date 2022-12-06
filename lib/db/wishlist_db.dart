import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:starshmucks/model/wishlist_model.dart';

class WishlistDB {
  Future<Database> initDBWishlist() async {
    String databasepath = await getDatabasesPath();
    final path = join(databasepath, "Wishlist.db");
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE IF NOT EXISTS WishlistTable(
          id INT NOT NULL UNIQUE
          )
          """);
      },
      version: 1,
    );
  }

  Future<bool> insertDataWishlist(WishlistModel item) async {
    final Database db = await initDBWishlist();
    int count = await db.insert("WishlistTable", item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    if (count == 1)
      return true;
    else
      return false;
    // print("count");
    // print(count);
  }

  Future<List<WishlistModel>> getDataWishlist() async {
    final Database db = await initDBWishlist();
    final List<Map<String, dynamic?>> data = await db.query("WishlistTable");
    return data.map((e) => WishlistModel.fromJson(e)).toList();
  }

  Future<void> deleteitemFromWishlist(WishlistModel item) async {
    final db = await initDBWishlist();
    await db.delete(
      'WishlistTable',
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }
}
