import 'dart:convert';

class ProgressModel {
  final int? id;
  final String exercise;
  final String weight;
  final String reps;
  final String date;

  ProgressModel({
    this.id,
    required this.exercise,
    required this.weight,
    required this.reps,
    required this.date,
  });

  /// Convert object to Map (for database insert/update)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'exercise': exercise,
      'weight': weight,
      'reps': reps,
      'date': date,
    };
  }

  /// Convert Map (from database) to object
  factory ProgressModel.fromMap(Map<String, dynamic> map) {
    return ProgressModel(
      id: map['id'],
      exercise: map['exercise'] ?? '',
      weight: map['weight'] ?? '',
      reps: map['reps'] ?? '',
      date: map['date'] ?? '',
    );
  }

  /// Convert object to JSON
  String toJson() => json.encode(toMap());

  /// Convert JSON to object
  factory ProgressModel.fromJson(String source) =>
      ProgressModel.fromMap(json.decode(source));
}
