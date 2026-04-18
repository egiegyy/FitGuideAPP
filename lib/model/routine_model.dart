import 'package:cloud_firestore/cloud_firestore.dart';

class RoutineModel {
  final int? id;
  final String? firestoreId;
  final String day;
  final String exercise;

  RoutineModel({
    this.id,
    this.firestoreId,
    required this.day,
    required this.exercise,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firestore_id': firestoreId,
      'day': day,
      'exercise': exercise,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {'day': day, 'exercise': exercise};
  }

  factory RoutineModel.fromMap(Map<String, dynamic> map) {
    return RoutineModel(
      id: map['id'],
      firestoreId: map['firestore_id'] ?? map['firestoreId'],
      day: map['day'] ?? '',
      exercise: map['exercise'] ?? '',
    );
  }

  factory RoutineModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    return RoutineModel.fromMap({
      'firestore_id': doc.id,
      ...?doc.data(),
    });
  }

  RoutineModel copyWith({
    int? id,
    String? firestoreId,
    String? day,
    String? exercise,
  }) {
    return RoutineModel(
      id: id ?? this.id,
      firestoreId: firestoreId ?? this.firestoreId,
      day: day ?? this.day,
      exercise: exercise ?? this.exercise,
    );
  }
}
