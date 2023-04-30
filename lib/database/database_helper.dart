import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  static const table = 'Geometry';

  static const columnId = 'id';
  static const lat = 'lat';
  static const lon = 'lon';
  static const city = 'city';

  late Database _db;

  // this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE Geometry(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, lat TEXT, lon TEXT, city TEXT)
          ''');
  }

  Future<int> insert(dynamic lat, dynamic lon, dynamic city) async {
    var result = await _db.rawQuery('SELECT * FROM $table WHERE city="$city"');

    if (result.isNotEmpty) {
      return 0;
    }

    Map<String, dynamic> row = {
      DatabaseHelper.lat: lat,
      DatabaseHelper.lon: lon,
      DatabaseHelper.city: city,
    };

    return await _db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _db.query(table);
  }

  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> update(Map<String, dynamic> row) async {
    int id = row[columnId];
    return await _db.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<void> delete(String city) async {
    return await _db.execute("DELETE FROM $table WHERE city='$city'");
  }

  Future<void> changeIndex(
      int oldIndex, int newIndex, Map<String, dynamic> row) async {
    // _currentWeatherLocations.insert(newIndex, item);
    await _db.execute(
        "DELETE FROM $table WHERE id = (SELECT id FROM $table LIMIT 1 OFFSET ${oldIndex - 1});");
    await _db.execute(
        "INSERT INTO $table WHERE id = (SELECT id FROM $table LIMIT 1 OFFSET ${oldIndex - 1});");
  }
}
