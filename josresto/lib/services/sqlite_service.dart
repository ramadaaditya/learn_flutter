import 'package:flutter/material.dart';
import 'package:josresto/data/model/restaurant.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static const String _databaseName = 'favoriteRestaurant.db';
  static const String _tableName = 'restaurant';
  static const int _version = 1;

  static final SqliteService _instance = SqliteService._internal();
  factory SqliteService() => _instance;
  SqliteService._internal();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDb();
    return _database!;
  }

  Future<void> _createTables(Database db) async {
    await db.execute('''CREATE TABLE $_tableName(
      id TEXT PRIMARY KEY NOT NULL,
      name TEXT NOT NULL,
      description TEXT NOT NULL,
      pictureId TEXT NOT NULL,
      city TEXT NOT NULL,
      address TEXT NOT NULL,
      rating DOUBLE NOT NULL
      )''');
  }

  Future<Database> _initializeDb() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(
      path,
      version: _version,
      onCreate: (db, version) async => await _createTables(db),
    );
  }

  Future<int> insertFavorite(Restaurant restaurant) async {
    try {
      final db = await database;
      return db.insert(
          _tableName,
          {
            'id': restaurant.id,
            'name': restaurant.name,
            'description': restaurant.description,
            'pictureId': restaurant.pictureId,
            'city': restaurant.city,
            'address': restaurant.address,
            'rating': restaurant.rating,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      debugPrint("Error inserting item: $e");
      return 0;
    }
  }

  Future<List<Restaurant>> getFavorites() async {
    try {
      final db = await database;
      final result = await db.query(_tableName);

      return result.map((data) => Restaurant.fromJson(data)).toList();
    } catch (e) {
      debugPrint("Error fetching all items: $e");
      return [];
    }
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<int> removeItem(String id) async {
    try {
      final db = await database;
      return db.delete(_tableName, where: "id = ?", whereArgs: [id]);
    } catch (e) {
      debugPrint("Error deleting item: $e");
      return 0;
    }
  }
}
