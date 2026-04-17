import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitguide/firebase/services/models/user_firebase_model.dart';
import 'package:fitguide/firebase/services/firebase_service.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // REGISTER
  static Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    await FirebaseService.registerUser(
      email: email,
      password: password,
      username: username,
    );
  }

  // LOGIN
  static Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await FirebaseService.loginUser(email: email, password: password);
  }

  // GET CURRENT USER
  static Future<UserFirebaseModel?> getCurrentUser() async {
    return await FirebaseService.getCurrentUser();
  }

  // SIGN OUT
  static Future<void> signOut() async {
    await _auth.signOut();
  }
}
