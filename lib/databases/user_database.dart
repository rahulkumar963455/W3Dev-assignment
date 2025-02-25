import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        uid INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        useremail TEXT NOT NULL,
        userprofilepic TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE notifications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        message TEXT NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertUser(AppUser user) async {
    final db = await database;
    return await db.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<AppUser>> fetchUsers() async {
    final db = await database;
    final result = await db.query('users');
    return result.map((map) => AppUser.fromMap(map)).toList();
  }

  Future<int> deleteUser(int uid) async {
    final db = await database;
    return await db.delete('users', where: 'uid = ?', whereArgs: [uid]);
  }

  // Notification database operations
  Future<int> insertNotification(NotificationData notification) async {
    final db = await database;
    return await db.insert('notifications', notification.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<NotificationData>> fetchNotifications() async {
    final db = await database;
    final result = await db.query('notifications');
    return result.map((map) => NotificationData.fromMap(map)).toList();
  }

  Future<int> deleteNotification(int id) async {
    final db = await database;
    return await db.delete('notifications', where: 'id = ?', whereArgs: [id]);
  }
}
