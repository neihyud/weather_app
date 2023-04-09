import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:weather_app/models/Geometry.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static final dbname = "geo.db";

  static final TABLE = "Geometry";

  static final columnId = "id";
  static final columnLat = "lat";
  static final columnLng = "lng";

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initiateDatabase();
    return _database;
  }

  initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbname);
    return await openDatabase(path,
        version: 1, onOpen: (db) {}, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    return await db.execute('''
         CREATE TABLE $TABLE (
            $columnId INTEGER AUTO INCREMENT,
            $columnLat TEXT NOT NULL,
            $columnLng TEXT NOT NULL
         )
      ''');
  }

  Future<void> newGeometry(Geometry newGeometry) async {
    var dbClient = await db;

    // return await dbClient.insert("Geometry");

    // var res = await db.rawInsert("INSERT Into Client (id,first_name)"
    //     " VALUES (${newClient.id},${newClient.firstName})");
    // return res;
  }
  
  // insert(String s) {}

  // Future<int> insert(Map<String, dynamic> row) async {
  //   Database? db = await db.database;
  //   return await db!.insert(tablename, row);
  // }
}
