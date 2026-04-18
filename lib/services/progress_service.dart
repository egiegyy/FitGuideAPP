import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitguide/model/progress_model.dart';
import 'package:fitguide/services/auth_service.dart';

class ProgressService {
  static const int defaultLimit = 50;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final Map<String, int> _docToLocalId = {};
  static final Map<int, String> _localIdToDoc = {};
  static int _nextLocalId = 1;

  static CollectionReference<Map<String, dynamic>> _collection(String userId) {
    return _firestore.collection('users').doc(userId).collection('progress');
  }

  static int _localIdForDoc(String docId) {
    final existing = _docToLocalId[docId];
    if (existing != null) return existing;

    final localId = _nextLocalId++;
    _docToLocalId[docId] = localId;
    _localIdToDoc[localId] = docId;
    return localId;
  }

  static String _requireUserId() {
    final userId = AuthService.getCurrentUserId();
    if (userId == null) {
      throw Exception('User is not logged in');
    }
    return userId;
  }

  static Future<int> addProgress(ProgressModel progress) async {
    final userId = _requireUserId();

    try {
      final doc = await _collection(userId).add(progress.toFirestore());
      return _localIdForDoc(doc.id);
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Failed to add progress');
    }
  }

  static Future<List<ProgressModel>> getProgress({
    int limit = defaultLimit,
  }) async {
    final userId = _requireUserId();

    try {
      final snap = await _collection(
        userId,
      ).orderBy('date', descending: false).limit(limit).get();

      return snap.docs.map((doc) {
        return ProgressModel.fromFirestore(doc).copyWith(
          id: _localIdForDoc(doc.id),
          firestoreId: doc.id,
        );
      }).toList();
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Failed to get progress');
    }
  }

  static Future<int> updateProgress(ProgressModel progress) async {
    final userId = _requireUserId();
    final docId = progress.firestoreId ?? _localIdToDoc[progress.id];

    if (docId == null) {
      throw Exception('Progress document ID was not found');
    }

    try {
      await _collection(userId).doc(docId).set(
        progress.toFirestore(),
        SetOptions(merge: true),
      );
      return 1;
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Failed to update progress');
    }
  }

  static Future<int> deleteProgress(int id) async {
    final userId = _requireUserId();
    final docId = _localIdToDoc[id];

    if (docId == null) {
      throw Exception('Progress document ID was not found');
    }

    try {
      await _collection(userId).doc(docId).delete();
      _localIdToDoc.remove(id);
      _docToLocalId.remove(docId);
      return 1;
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Failed to delete progress');
    }
  }
}
