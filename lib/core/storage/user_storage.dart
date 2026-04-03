import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:gas_app/features/auth/domain/entities/user.dart';

abstract class UserStorage {
  Future<void> saveUser(User user);
  User? getUser();
  Future<void> clear();
}

class LocalUserStorage implements UserStorage {
  final SharedPreferences prefs;

  static const _key = 'user';

  LocalUserStorage(this.prefs);

  @override
  Future<void> saveUser(User user) async {
    await prefs.setString(_key, jsonEncode(user.toJson()));
  }

  @override
  User? getUser() {
    final raw = prefs.getString(_key);
    if (raw == null) return null;
    return User.fromJson(jsonDecode(raw));
  }

  @override
  Future<void> clear() async {
    await prefs.remove(_key);
  }
}
