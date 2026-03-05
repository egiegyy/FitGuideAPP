import 'dart:convert';

class ProgressModel {
  int? id;
  String name;
  String age;
  String weight;
  String height;

  ProgressModel({
    this.id,
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'weight': weight,
      'height': height,
    };
  }

  factory ProgressModel.fromMap(Map<String, dynamic> map) {
    return ProgressModel(
      id: map['id'],
      name: map['name'] ?? '',
      age: map['age'] ?? '',
      weight: map['weight'] ?? '',
      height: map['height'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProgressModel.fromJson(String source) =>
      ProgressModel.fromMap(json.decode(source));
}
