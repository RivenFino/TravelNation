import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
    
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'travelnation4.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE destinations(id INTEGER PRIMARY KEY AUTOINCREMENT, destinationName TEXT, location TEXT, description TEXT, imagePath TEXT)",
        );
      },
    );
  }

  Future<int> insertDestination(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('destinations', row);
  }

  Future<List<Map<String, dynamic>>> queryAllDestinations() async {
    Database db = await database;
    return await db.query('destinations');
  }

  Future<int> updateDestination(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('destinations', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteDestination(int id) async {
    Database db = await database;
    return await db.delete('destinations', where: 'id = ?', whereArgs: [id]);
  }

  
}
