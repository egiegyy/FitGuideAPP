import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  /// GET DATABASE INSTANCE
  static Future<Database> db() async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  /// INIT DATABASE
  static Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'fitguide.db');

    return await openDatabase(
      path,
      version: 2,

      /// FIRST CREATE DATABASE
      onCreate: (db, version) async {
        /// TABLE PROGRESS
        await db.execute('''
        CREATE TABLE progress (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          age TEXT,
          weight TEXT,
          height TEXT
        )
        ''');

        /// TABLE ROUTINE
        await db.execute('''
        CREATE TABLE routine (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          day TEXT,
          exercise TEXT
        )
        ''');
      },

      /// DATABASE MIGRATION
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
          CREATE TABLE IF NOT EXISTS routine (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            day TEXT,
            exercise TEXT
          )
          ''');
        }
      },
    );
  }

  /// INSERT ROUTINE (PREVENT DUPLICATE)
  static Future<int?> insertRoutine(String day, String exercise) async {
    final db = await DBHelper.db();

    final exist = await db.query(
      'routine',
      where: 'day = ? AND exercise = ?',
      whereArgs: [day, exercise],
    );

    if (exist.isNotEmpty) {
      return null;
    }

    return await db.insert('routine', {'day': day, 'exercise': exercise});
  }

  /// GET ROUTINE BY DAY
  static Future<List<Map<String, dynamic>>> getRoutineByDay(String day) async {
    final db = await DBHelper.db();

    return await db.query('routine', where: 'day = ?', whereArgs: [day]);
  }

  /// GET ALL ROUTINE DAYS
  static Future<List<String>> getRoutineDays() async {
    final db = await DBHelper.db();

    final result = await db.rawQuery(
      "SELECT DISTINCT day FROM routine ORDER BY id ASC",
    );

    return result.map((e) => e['day'] as String).toList();
  }

  /// GET EXERCISE PREVIEW (FIRST 2 EXERCISES PER DAY)
  static Future<List<String>> getRoutineExercisePreview(String day) async {
    final db = await DBHelper.db();

    final result = await db.query(
      'routine',
      columns: ['exercise'],
      where: 'day = ?',
      whereArgs: [day],
      limit: 2,
    );

    return result.map((e) => e['exercise'] as String).toList();
  }

  /// DELETE ROUTINE
  static Future<int> deleteRoutine(int id) async {
    final db = await DBHelper.db();

    return await db.delete('routine', where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> insertProgress(Map<String, dynamic> data) async {
    final db = await DBHelper.db();
    return await db.insert('progress', data);
  }

  static Future<List<Map<String, dynamic>>> getProgress() async {
    final db = await DBHelper.db();
    return await db.query('progress');
  }

  static Future<int> updateProgress(int id, Map<String, dynamic> data) async {
    final db = await DBHelper.db();

    return await db.update('progress', data, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteProgress(int id) async {
    final db = await DBHelper.db();

    return await db.delete('progress', where: 'id = ?', whereArgs: [id]);
  }
}
