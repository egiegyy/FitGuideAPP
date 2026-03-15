import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitguide/database/sqflite.dart';

class UserPref {
  static const String userKey = "users";
  static const String loginUserKey = "loginUser";

  /// REGISTER USER
  static Future<bool> saveUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> users = prefs.getStringList(userKey) ?? [];

    /// cek duplicate username/email
    for (var user in users) {
      final decoded = jsonDecode(user);

      if (decoded["username"] == username) {
        return false;
      }

      if (decoded["email"] == email) {
        return false;
      }
    }

    Map<String, dynamic> newUser = {
      "username": username.trim(),
      "email": email.trim(),
      "password": password.trim(),
    };

    users.add(jsonEncode(newUser));

    await prefs.setStringList(userKey, users);

    return true;
  }

  /// GET ALL USERS
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> users = prefs.getStringList(userKey) ?? [];

    return users.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
  }

  /// LOGIN USER (USERNAME BASED)
  static Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    final users = await getUsers();

    for (var user in users) {
      if (user["username"].toString().toLowerCase() == username.toLowerCase() &&
          user["password"] == password) {
        /// reset database supaya database user sebelumnya tidak dipakai
        await DBHelper.resetDB();

        /// simpan user login
        await prefs.setString(loginUserKey, user["username"]);

        return true;
      }
    }

    return false;
  }

  /// GET CURRENT LOGIN USER
  static Future<String?> getLoginUser() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(loginUserKey);
  }

  /// CHECK LOGIN STATUS
  static Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();

    final user = prefs.getString(loginUserKey);

    return user != null;
  }

  /// LOGOUT USER
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    /// reset database connection
    await DBHelper.resetDB();

    await prefs.remove(loginUserKey);
  }
}
