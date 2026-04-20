import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProgressModel {
  final int? id;
  final String? firestoreId;
  final String exercise;
  final String weight;
  final String reps;
  final String date;

  ProgressModel({
    this.id,
    this.firestoreId,
    required this.exercise,
    required this.weight,
    required this.reps,
    required this.date,
  });

  /// Convert object to Map (for database insert/update)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firestore_id': firestoreId,
      'exercise': exercise,
      'weight': weight,
      'reps': reps,
      'date': date,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {'exercise': exercise, 'weight': weight, 'reps': reps, 'date': date};
  }

  /// Convert Map to object
  factory ProgressModel.fromMap(Map<String, dynamic> map) {
    return ProgressModel(
      id: map['id'],
      firestoreId: map['firestore_id'] ?? map['firestoreId'],
      exercise: map['exercise'] ?? '',
      weight: map['weight'] ?? '',
      reps: map['reps'] ?? '',
      date: map['date'] ?? '',
    );
  }

  factory ProgressModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    return ProgressModel.fromMap({
      'firestore_id': doc.id,
      ...?doc.data(),
    });
  }

  ProgressModel copyWith({
    int? id,
    String? firestoreId,
    String? exercise,
    String? weight,
    String? reps,
    String? date,
  }) {
    return ProgressModel(
      id: id ?? this.id,
      firestoreId: firestoreId ?? this.firestoreId,
      exercise: exercise ?? this.exercise,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      date: date ?? this.date,
    );
  }

  /// ini object to JSON
  String toJson() => json.encode(toMap());

  /// ini JSON to object
  factory ProgressModel.fromJson(String source) =>
      ProgressModel.fromMap(json.decode(source));
}
