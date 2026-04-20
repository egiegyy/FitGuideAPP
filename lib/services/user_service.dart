import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitguide/services/models/user_firebase_model.dart';

class UserService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static DocumentReference<Map<String, dynamic>> _userDoc(String userId) {
    return _firestore.collection('users').doc(userId);
  }

  static Future<void> createUser(UserFirebaseModel user) async {
    try {
      await _userDoc(user.uid).set(user.toFirestore(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Failed to create user data');
    }
  }

  static Future<void> updateUser({
    required String userId,
    String? username,
    String? email,
    String? profileImageUrl,
  }) async {
    final data = <String, dynamic>{};
    if (username != null) data['username'] = username;
    if (email != null) data['email'] = email;
    if (profileImageUrl != null) data['profileImageUrl'] = profileImageUrl;

    if (data.isEmpty) return;

    try {
      await _userDoc(userId).set(data, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Failed to update user data');
    }
  }

  static Future<UserFirebaseModel?> getUserData(String userId) async {
    try {
      final snap = await _userDoc(userId).get();
      if (!snap.exists) return null;

      return UserFirebaseModel.fromFirestore(snap);
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Failed to get user data');
    }
  }

  static Future<UserFirebaseModel?> getCurrentUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    return getUserData(user.uid);
  }

  static Future<String> uploadProfileImage({
    required String userId,
    required String localPath,
  }) async {
    try {
      final file = File(localPath);
      final ref = _storage.ref().child('users/$userId/profile.jpg');
      final upload = await ref.putFile(
        file,
        SettableMetadata(contentType: 'image/jpeg'),
      );
      final url = await upload.ref.getDownloadURL();
      await updateUser(userId: userId, profileImageUrl: url);
      return url;
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Failed to upload profile image');
    }
  }
}
