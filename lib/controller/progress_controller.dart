import 'package:fitguide/model/progress_model.dart';
import 'package:fitguide/services/progress_service.dart';

class ProgressController {
  /// INSERT WORKOUT PROGRESS
  static Future<void> insertProgress(ProgressModel progress) async {
    await ProgressService.addProgress(progress);
  }

  /// GET ALL WORKOUT PROGRESS (OLDEST FIRST FOR CHART)
  static Future<List<ProgressModel>> getAllProgress() async {
    return ProgressService.getProgress();
  }

  /// UPDATE WORKOUT PROGRESS
  static Future<int> updateProgress(ProgressModel progress) async {
    if (progress.id == null) {
      throw Exception("Progress ID is required for update");
    }
    return ProgressService.updateProgress(progress);
  }

  /// DELETE WORKOUT PROGRESS
  static Future<int> deleteProgress(int id) async {
    return ProgressService.deleteProgress(id);
  }
}
