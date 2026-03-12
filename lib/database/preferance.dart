import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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

    String u = username.trim();
    String e = email.trim();
    String p = password.trim();

    /// cegah register kosong
    if (u.isEmpty || e.isEmpty || p.isEmpty) {
      return false;
    }

    /// cek username sudah ada atau belum
    for (var userString in users) {
      final user = jsonDecode(userString) as Map<String, dynamic>;

      if (user["username"] == u) {
        return false;
      }
    }

    Map<String, dynamic> newUser = {"username": u, "email": e, "password": p};

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

  /// LOGIN USER
  static Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    String u = username.trim();
    String p = password.trim();

    /// cegah login kosong
    if (u.isEmpty || p.isEmpty) {
      return false;
    }

    final users = await getUsers();

    for (var user in users) {
      if (user["username"] == u && user["password"] == p) {
        /// simpan username yang login
        await prefs.setString(loginUserKey, user["username"]);
        return true;
      }
    }

    return false;
  }

  /// GET USER YANG LOGIN
  static Future<String?> getLoginUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(loginUserKey);
  }

  /// CEK LOGIN STATUS
  static Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(loginUserKey) != null;
  }

  /// LOGOUT
  static Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(loginUserKey);
  }

  /// DELETE ACCOUNT
  static Future<void> deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();

    String? loginUser = prefs.getString(loginUserKey);

    if (loginUser == null) return;

    List<String> users = prefs.getStringList(userKey) ?? [];

    users.removeWhere((userString) {
      final user = jsonDecode(userString) as Map<String, dynamic>;
      return user["username"] == loginUser;
    });

    await prefs.setStringList(userKey, users);

    /// hapus profile image user
    await prefs.remove("profile_$loginUser");

    /// logout setelah delete
    await prefs.remove(loginUserKey);
  }

  /// SAVE PROFILE IMAGE
  static Future<void> saveProfileImage(String username, String path) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("profile_$username", path);
  }

  /// GET PROFILE IMAGE
  static Future<String?> getProfileImage(String username) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("profile_$username");
  }

  /// DELETE PROFILE IMAGE
  static Future<void> deleteProfileImage(String username) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("profile_$username");
  }
}
