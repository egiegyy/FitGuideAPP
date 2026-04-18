import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirebaseModel {
  final String uid;
  final String email;
  final String username;
  final String profileImageUrl;
  final DateTime createdAt;

  UserFirebaseModel({
    required this.uid,
    required this.email,
    required this.username,
    this.profileImageUrl = '',
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      'username': username,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserFirebaseModel.fromMap(Map<String, dynamic> map) {
    return UserFirebaseModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      profileImageUrl: map['profileImageUrl'] as String? ?? '',
      createdAt: _parseDate(map['createdAt']),
    );
  }

  factory UserFirebaseModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    return UserFirebaseModel.fromMap({'uid': doc.id, ...?doc.data()});
  }

  static DateTime _parseDate(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String && value.isNotEmpty) return DateTime.parse(value);
    return DateTime.now();
  }
}
