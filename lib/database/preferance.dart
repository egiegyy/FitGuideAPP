import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitguide/database/sqflite.dart';

class UserPref {
  static const String userKey = "users";
  static const String loginUserKey = "loginUser";
  static const String profileImageKey = "profileImages";

  /// REGISTER USER
  static Future<bool> saveUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> users = prefs.getStringList(userKey) ?? [];

    /// cek email sudah ada
    for (var user in users) {
      Map<String, dynamic> decoded = jsonDecode(user);

      if (decoded["email"] == email) {
        return false;
      }
    }

    Map<String, dynamic> newUser = {
      "username": username,
      "email": email,
      "password": password,
    };

    users.add(jsonEncode(newUser));

    await prefs.setStringList(userKey, users);

    return true;
  }

  /// GET USERS
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> users = prefs.getStringList(userKey) ?? [];

    return users.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
  }

  /// LOGIN (EMAIL)
  static Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    final users = await getUsers();

    for (var user in users) {
      if (user["email"] == email && user["password"] == password) {
        /// reset database supaya user sebelumnya tidak terbawa
        await DBHelper.resetDB();

        await prefs.setString(loginUserKey, email);

        return true;
      }
    }

    return false;
  }

  /// GET LOGIN EMAIL
  static Future<String?> getLoginUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(loginUserKey);
  }

  /// GET CURRENT USER DATA
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    String? email = await getLoginUser();

    if (email == null) return null;

    final users = await getUsers();

    for (var user in users) {
      if (user["email"] == email) {
        return user;
      }
    }

    return null;
  }

  /// SAVE LOGIN EMAIL
  static Future<void> saveLoginUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(loginUserKey, email);
  }

  /// GET USERNAME FROM EMAIL
  static Future<String?> getUsername(String email) async {
    final users = await getUsers();

    for (var user in users) {
      if (user["email"] == email) {
        return user["username"];
      }
    }

    return null;
  }

  /// CHECK LOGIN
  static Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(loginUserKey) != null;
  }

  /// LOGOUT
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    /// reset database ketika logout
    await DBHelper.resetDB();

    await prefs.remove(loginUserKey);
  }

  /// DELETE ACCOUNT
  static Future<void> deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();

    String? email = prefs.getString(loginUserKey);

    if (email == null) return;

    List<String> users = prefs.getStringList(userKey) ?? [];

    users.removeWhere((user) {
      Map<String, dynamic> decoded = jsonDecode(user);
      return decoded["email"] == email;
    });

    await prefs.setStringList(userKey, users);

    /// hapus foto profile jika ada
    String? data = prefs.getString(profileImageKey);

    if (data != null) {
      Map<String, dynamic> images = jsonDecode(data);
      images.remove(email);

      await prefs.setString(profileImageKey, jsonEncode(images));
    }

    /// reset database setelah delete
    await DBHelper.resetDB();

    await prefs.remove(loginUserKey);
  }

  /// SAVE PROFILE IMAGE
  static Future<void> saveProfileImage(String email, String path) async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, String> images = {};

    String? data = prefs.getString(profileImageKey);

    if (data != null) {
      images = Map<String, String>.from(jsonDecode(data));
    }

    images[email] = path;

    await prefs.setString(profileImageKey, jsonEncode(images));
  }

  /// GET PROFILE IMAGE
  static Future<String?> getProfileImage(String email) async {
    final prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString(profileImageKey);

    if (data == null) return null;

    Map<String, dynamic> images = jsonDecode(data);

    return images[email];
  }
}
