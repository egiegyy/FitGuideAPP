import 'package:fitguide/model/progress_model.dart';
import 'package:fitguide/services/progress_service.dart';
import 'package:fitguide/services/routine_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  /// RESET DATABASE CONNECTION
  static Future<void> resetDB() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }

  /// GET LOCAL DATABASE INSTANCE
  static Future<Database> db() async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDb();
    return _db!;
  }

  /// INIT DATABASE FOR BARCODE EQUIPMENT ONLY
  static Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'fitguide_equipment.db');

    return openDatabase(
      path,
      version: 6,
      onCreate: (db, version) async {
        await _createEquipmentTable(db);
        await _createLegacyCleanupTables(db);
        await _seedEquipment(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await _createEquipmentTable(db);
        await _createLegacyCleanupTables(db);
        await _seedEquipment(db);
      },
    );
  }

  static Future<void> _createEquipmentTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS equipment (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      barcode TEXT UNIQUE,
      name TEXT,
      page TEXT,
      muscle TEXT,
      description TEXT,
      animation TEXT
    )
    ''');
  }

  static Future<void> _createLegacyCleanupTables(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS progress (
      id INTEGER PRIMARY KEY AUTOINCREMENT
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS routine (
      id INTEGER PRIMARY KEY AUTOINCREMENT
    )
    ''');
  }

  static Future<void> _seedEquipment(Database db) async {
    await db.insert('equipment', {
      'barcode': 'LAT001',
      'name': 'Lat Pulldown',
      'page': 'lat_pulldown',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);

    await db.insert('equipment', {
      'barcode': 'CHEST001',
      'name': 'Chest Press',
      'page': 'chest_press',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);

    await db.insert('equipment', {
      'barcode': 'LEG001',
      'name': 'Leg Press',
      'page': 'leg_press',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  /// CHECK EQUIPMENT BY BARCODE (LOCAL ONLY)
  static Future<Map<String, dynamic>?> getEquipmentByBarcode(
    String barcode,
  ) async {
    final db = await DBHelper.db();
    final result = await db.query(
      'equipment',
      where: 'barcode = ?',
      whereArgs: [barcode],
      limit: 1,
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  /// ROUTINE COMPATIBILITY METHODS: FIRESTORE ONLY
  static Future<int?> insertRoutine(String day, String exercise) async {
    return RoutineService.addRoutine(day, exercise);
  }

  static Future<List<Map<String, dynamic>>> getRoutineByDay(String day) async {
    return RoutineService.getRoutineByDay(day);
  }

  static Future<List<String>> getRoutineDays() async {
    return RoutineService.getAllRoutineDays();
  }

  static Future<int> deleteRoutine(int id) async {
    return RoutineService.deleteRoutine(id);
  }

  /// PROGRESS COMPATIBILITY METHODS: FIRESTORE ONLY
  static Future<int> insertProgress(Map<String, dynamic> data) async {
    return ProgressService.addProgress(ProgressModel.fromMap(data));
  }

  static Future<List<Map<String, dynamic>>> getProgress() async {
    final progress = await ProgressService.getProgress();
    return progress.map((e) => e.toMap()).toList();
  }

  static Future<int> deleteProgress(int id) async {
    return ProgressService.deleteProgress(id);
  }
}
