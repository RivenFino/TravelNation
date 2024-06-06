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
    String path = join(await getDatabasesPath(), 'travelnation1000.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE destinations(id INTEGER PRIMARY KEY AUTOINCREMENT, destination TEXT, location TEXT, description TEXT, imagePath TEXT)",
        );
        db.execute(
          "CREATE TABLE bookmarks(id INTEGER PRIMARY KEY AUTOINCREMENT, destinationId INTEGER)",
        );
      },
    );
  }

  Future<Map<String, dynamic>?> getDestinationById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'destinations',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> searchDestination(String search) async {
    final db = await database;
    return await db.query('destinations',
        where: 'destination LIKE ?', whereArgs: ['%$search%']);
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
    return await db
        .update('destinations', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteDestination(int id) async {
    Database db = await database;
    return await db.delete('destinations', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> addBookmark(int destinationId) async {
    Database db = await database;
    Map<String, dynamic> bookmark = {'destinationId': destinationId};
    return await db.insert('bookmarks', bookmark);
  }

  Future<int> removeBookmark(int destinationId) async {
    Database db = await database;
    return await db.delete('bookmarks',
        where: 'destinationId = ?', whereArgs: [destinationId]);
  }

  Future<bool> isBookmarked(int destinationId) async {
    Database db = await database;
    List<Map<String, dynamic>> bookmarks = await db.query(
      'bookmarks',
      where: 'destinationId = ?',
      whereArgs: [destinationId],
    );
    return bookmarks.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getBookmarks() async {
    final db = await database;
    return await db.query('bookmarks');
  }
}
