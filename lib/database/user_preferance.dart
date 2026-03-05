import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  static const String userKey = "users";
  static const String loginUserKey = "loginUser";

  static Future<void> saveUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> users = prefs.getStringList(userKey) ?? [];

    Map<String, dynamic> newUser = {
      "username": username,
      "email": email,
      "password": password,
    };

    users.add(jsonEncode(newUser));

    await prefs.setStringList(userKey, users);
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> users = prefs.getStringList(userKey) ?? [];

    return users.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
  }

  static Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    final users = await getUsers();

    for (var user in users) {
      if (user["username"] == username && user["password"] == password) {
        await prefs.setString(loginUserKey, username);

        return true;
      }
    }

    return false;
  }

  static Future<String?> getLoginUser() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(loginUserKey);
  }
}
