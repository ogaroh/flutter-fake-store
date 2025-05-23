import 'dart:convert';
import 'package:fake_store/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SharedPreferencesManager {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  final SharedPreferences _prefs;

  SharedPreferencesManager(this._prefs);

  // Token management
  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  Future<void> deleteToken() async {
    await _prefs.remove(_tokenKey);
  }

  // User management
  Future<void> saveUser(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await _prefs.setString(_userKey, userJson);
  }

  UserModel? getUser() {
    final userJson = _prefs.getString(_userKey);
    if (userJson == null) return null;
    try {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteUser() async {
    await _prefs.remove(_userKey);
  }

  // Clear all auth data
  Future<void> clearAuthData() async {
    await deleteToken();
    await deleteUser();
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return getToken() != null;
  }
}
