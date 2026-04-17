import 'package:cloud_firestore/cloud_firestore.dart';

class StudentFirebaseModel {
  final String id;
  final String name;
  final String email;
  final String studentClass;
  final int age;

  StudentFirebaseModel({
    required this.id,
    required this.name,
    required this.email,
    required this.studentClass,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'class': studentClass,
      'age': age,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory StudentFirebaseModel.fromMap(Map<String, dynamic> map) {
    return StudentFirebaseModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      studentClass: map['class'] as String? ?? '',
      age: (map['age'] as num?)?.toInt() ?? 0,
    );
  }

  factory StudentFirebaseModel.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return StudentFirebaseModel(
      id: doc.id,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      studentClass: data['class'] as String? ?? '',
      age: (data['age'] as num?)?.toInt() ?? 0,
    );
  }
}
