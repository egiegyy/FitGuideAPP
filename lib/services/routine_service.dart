import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitguide/model/routine_model.dart';
import 'package:fitguide/services/auth_service.dart';
import 'package:flutter/foundation.dart';

class RoutineService {
  static const int defaultLimit = 100;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final Map<String, int> _docToLocalId = {};
  static final Map<int, String> _localIdToDoc = {};
  static int _nextLocalId = 1;

  static CollectionReference<Map<String, dynamic>> _collection(String userId) {
    return _firestore.collection('users').doc(userId).collection('routine');
  }

  static const Map<String, String> _dayAliases = {
    'monday': 'Monday',
    'senin': 'Monday',
    'tuesday': 'Tuesday',
    'selasa': 'Tuesday',
    'wednesday': 'Wednesday',
    'rabu': 'Wednesday',
    'thursday': 'Thursday',
    'kamis': 'Thursday',
    'friday': 'Friday',
    'jumat': 'Friday',
    "jum'at": 'Friday',
    'saturday': 'Saturday',
    'sabtu': 'Saturday',
    'sunday': 'Sunday',
    'minggu': 'Sunday',
  };

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

  static String _normalizeDay(String day) {
    final value = day.trim();
    return _dayAliases[value.toLowerCase()] ?? value;
  }

  static String _normalizeExercise(String exercise) {
    return exercise.trim();
  }

  static bool _sameDay(String left, String right) {
    return _normalizeDay(left).toLowerCase() ==
        _normalizeDay(right).toLowerCase();
  }

  static bool _sameExercise(String left, String right) {
    return _normalizeExercise(left).toLowerCase() ==
        _normalizeExercise(right).toLowerCase();
  }

  static Future<int?> addRoutine(String day, String exercise) async {
    final userId = _requireUserId();
    final normalizedDay = _normalizeDay(day);
    final normalizedExercise = _normalizeExercise(exercise);

    try {
      final duplicate = await _collection(userId)
          .where('day', isEqualTo: normalizedDay)
          .where('exercise', isEqualTo: normalizedExercise)
          .limit(1)
          .get();

      if (duplicate.docs.isNotEmpty) return null;

      final fallbackDuplicate = await _collection(
        userId,
      ).orderBy('day').limit(defaultLimit).get();

      final alreadyExists = fallbackDuplicate.docs.any((doc) {
        final routine = RoutineModel.fromFirestore(doc);
        return _sameDay(routine.day, normalizedDay) &&
            _sameExercise(routine.exercise, normalizedExercise);
      });

      if (alreadyExists) return null;

      final doc = await _collection(userId).add(
        RoutineModel(
          day: normalizedDay,
          exercise: normalizedExercise,
        ).toFirestore(),
      );

      return _localIdForDoc(doc.id);
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Failed to add routine');
    }
  }

  static Future<List<RoutineModel>> getRoutineModelsByDay(String day) async {
    final userId = _requireUserId();
    final normalizedDay = _normalizeDay(day);

    try {
      debugPrint(
        '[RoutineService] getRoutineByDay selectedDay="$day" normalizedDay="$normalizedDay"',
      );

      final snap = await _collection(userId)
          .where('day', isEqualTo: normalizedDay)
          .limit(defaultLimit)
          .get();

      debugPrint('[RoutineService] exact query result=${snap.docs.length}');
      for (final doc in snap.docs) {
        debugPrint('[RoutineService] doc=${doc.id} data=${doc.data()}');
      }

      var docs = snap.docs;

      if (docs.isEmpty) {
        final fallback = await _collection(
          userId,
        ).orderBy('day').limit(defaultLimit).get();

        docs = fallback.docs.where((doc) {
          final data = doc.data();
          return _sameDay(data['day']?.toString() ?? '', normalizedDay);
        }).toList();

        debugPrint(
          '[RoutineService] normalized fallback result=${docs.length}',
        );
        for (final doc in docs) {
          debugPrint(
            '[RoutineService] fallback doc=${doc.id} data=${doc.data()}',
          );
        }
      }

      final routines = docs.map((doc) {
        return RoutineModel.fromFirestore(doc).copyWith(
          id: _localIdForDoc(doc.id),
          firestoreId: doc.id,
        );
      }).toList()
        ..sort((a, b) => a.exercise.compareTo(b.exercise));

      return routines;
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Failed to get routine');
    }
  }

  static Future<List<Map<String, dynamic>>> getRoutineByDay(String day) async {
    final routines = await getRoutineModelsByDay(day);
    return routines.map((routine) => routine.toMap()).toList();
  }

  static Future<int> deleteRoutine(int id) async {
    final userId = _requireUserId();
    final docId = _localIdToDoc[id];

    if (docId == null) {
      throw Exception('Routine document ID was not found');
    }

    try {
      await _collection(userId).doc(docId).delete();
      _localIdToDoc.remove(id);
      _docToLocalId.remove(docId);
      return 1;
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Failed to delete routine');
    }
  }

  static Future<List<String>> getAllRoutineDays({
    int limit = defaultLimit,
  }) async {
    final userId = _requireUserId();

    try {
      final snap = await _collection(
        userId,
      ).orderBy('day').limit(limit).get();

      final days = <String>[];
      for (final doc in snap.docs) {
        final routine = RoutineModel.fromFirestore(doc);
        _localIdForDoc(doc.id);
        final day = _normalizeDay(routine.day);
        if (!days.contains(day)) {
          days.add(day);
        }
      }
      return days;
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Failed to get routine days');
    }
  }
}
