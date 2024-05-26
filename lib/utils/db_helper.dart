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
    String path = join(await getDatabasesPath(), 'crud.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE destination(id INTEGER PRIMARY KEY AUTOINCREMENT, destination TEXT, location TEXT, description TEXT)",
        );
      },
    );
  }

  Future<int> insertDestination(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('destination', row);
  }

  Future<List<Map<String, dynamic>>> queryAlldestinations() async {
    Database db = await database;
    return await db.query('destination');
  }

  Future<int> _updateDestination(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('destination', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> _deleteDestination(int id) async {
    Database db = await database;
    return await db.delete('destination', where: 'id = ?', whereArgs: [id]);
  }
}
