import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitguide/services/models/user_firebase_model.dart';
import 'package:fitguide/services/models/student_firebase_model.dart';
import 'package:fitguide/services/user_service.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // REGISTER
  static Future<UserFirebaseModel> registerUser({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = cred.user;
      if (user == null) {
        throw Exception('User gagal dibuat');
      }

      final model = UserFirebaseModel(
        uid: user.uid,
        email: email,
        username: username,
        createdAt: DateTime.now(),
      );

      await UserService.createUser(model);

      return model;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Register gagal');
    }
  }

  // LOGIN
  static Future<UserFirebaseModel?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = cred.user;
      if (user == null) return null;

      return await getCurrentUser();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Login gagal');
    }
  }

  // GET CURRENT USER FROM FIRESTORE
  static Future<UserFirebaseModel?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    return UserService.getUserData(user.uid);
  }

  // SAVE STUDENT
  static Future<void> createStudent(StudentFirebaseModel student) async {
    await _firestore.collection('students').add(student.toMap());
  }

  // GET STUDENTS
  static Future<List<StudentFirebaseModel>> getAllStudents() async {
    final snap = await _firestore.collection('students').get();
    return snap.docs.map((doc) => StudentFirebaseModel.fromDoc(doc)).toList();
  }

  // LOGOUT
  static Future<void> logoutUser() async {
    await _auth.signOut();
  }
}
