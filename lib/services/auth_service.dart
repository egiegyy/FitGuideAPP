import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitguide/database/preferance.dart';
import 'package:fitguide/model/user_firebase_model.dart';
import 'package:fitguide/services/firebase_service.dart';
import 'package:fitguide/services/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static bool _googleSignInInitialized = false;

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
    await UserPref.saveLoginUser(email);
  }

  // LOGIN
  static Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await FirebaseService.loginUser(email: email, password: password);
    await UserPref.saveLoginUser(email);
  }

  // GOOGLE LOGIN
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      await _ensureGoogleSignInInitialized();

      if (!GoogleSignIn.instance.supportsAuthenticate()) {
        throw FirebaseAuthException(
          code: 'google-sign-in-not-supported',
          message: 'Google Sign-In is not supported on this platform.',
        );
      }

      final googleUser = await GoogleSignIn.instance.authenticate();
      final googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final result = await _auth.signInWithCredential(credential);
      final user = result.user;
      if (user != null) {
        final email = user.email ?? user.uid;
        final name = user.displayName ?? email.split('@').first;
        await UserService.createUser(
          UserFirebaseModel(
            uid: user.uid,
            email: email,
            username: name,
            profileImageUrl: user.photoURL ?? '',
            createdAt: DateTime.now(),
          ),
        );
        await UserPref.saveLoginUser(email);
      }

      return result;
    } on GoogleSignInException catch (e) {
      if (e.code != GoogleSignInExceptionCode.canceled) {
        debugPrint('Google Sign-In Error: $e');
      }
      return null;
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      return null;
    }
  }

  static String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  static Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  static Future<void> _ensureGoogleSignInInitialized() async {
    if (_googleSignInInitialized) return;

    await GoogleSignIn.instance.initialize();
    _googleSignInInitialized = true;
  }

  // GET CURRENT USER
  static Future<UserFirebaseModel?> getCurrentUser() async {
    return await FirebaseService.getCurrentUser();
  }

  // SIGN OUT
  static Future<void> signOut() async {
    await UserPref.logout();
    await _auth.signOut();
  }
}
