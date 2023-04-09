import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_database.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Geometry(id INTEGER AUTO INCREMENT, lat TEXT, lng TEXT)");
  }

  Future<int> saveData(String tableName, Map<String, dynamic> data) async {
    var dbClient = await db;
    return await dbClient.insert(tableName, data);
  }

  Future<List<Map<String, dynamic>>> getData(String tableName) async {
    var dbClient = await db;
    return await dbClient.query(tableName);
  }

  Future<int> updateData(
      String tableName, Map<String, dynamic> data, int id) async {
    var dbClient = await db;
    return await dbClient.update(tableName, data, where: "id = ?", whereArgs: [id]);
  }

  Future<int> deleteData(String tableName, int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableName, where: "id = ?", whereArgs: [id]);
  }
}


// DatabaseHelper db = DatabaseHelper();

// // insert data
// await db.saveData("my_table", {"name": "John", "age": 30});

// // get all data
// List<Map<String, dynamic>> data = await db.getData("my_table");

// // update data
// await db.updateData("my_table", {"name": "Jane"}, 1);

// // delete data
// await db.deleteData("my_table", 1);
