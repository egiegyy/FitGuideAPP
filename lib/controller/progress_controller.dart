import 'package:fitguide/database/sqflite.dart';
import 'package:fitguide/firebase/model/progress_model.dart';

class ProgressController {
  /// INSERT WORKOUT PROGRESS
  static Future<void> insertProgress(ProgressModel progress) async {
    final db = await DBHelper.db();
    await db.insert('progress', progress.toMap());
  }

  /// GET ALL WORKOUT PROGRESS (OLDEST FIRST FOR CHART)
  static Future<List<ProgressModel>> getAllProgress() async {
    final db = await DBHelper.db();
    final results = await db.query('progress', orderBy: "date ASC");
    return results.map((e) => ProgressModel.fromMap(e)).toList();
  }
  /// UPDATE WORKOUT PROGRESS
  static Future<int> updateProgress(ProgressModel progress) async {
    final db = await DBHelper.db();

    if (progress.id == null) {
      throw Exception("Progress ID is required for update");
    }
    return await db.update(
      'progress',
      progress.toMap(),
      where: 'id = ?',
      whereArgs: [progress.id],
    );
  }

  /// DELETE WORKOUT PROGRESS
  static Future<int> deleteProgress(int id) async {
    final db = await DBHelper.db();

    return await db.delete('progress', where: 'id = ?', whereArgs: [id]);
  }
}
