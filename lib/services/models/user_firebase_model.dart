class UserFirebaseModel {
  final String uid;
  final String email;
  final String username;
  final DateTime createdAt;

  UserFirebaseModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserFirebaseModel.fromMap(Map<String, dynamic> map) {
    return UserFirebaseModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}
