import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IStorage {
  Future<void> write({required String key, required String value});
  Future<String?> read({required String key});
  Future<void> delete({required String key});
}

// Secure storage for mobile
class MobileStorage implements IStorage {
  final _storage = const FlutterSecureStorage();

  @override
  Future<void> write({required String key, required String value}) =>
      _storage.write(key: key, value: value);

  @override
  Future<String?> read({required String key}) => _storage.read(key: key);

  @override
  Future<void> delete({required String key}) => _storage.delete(key: key);
}

// Shared preferences for web
class WebStorage implements IStorage {
  @override
  Future<void> write({required String key, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Future<String?> read({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<void> delete({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}

// Factory to get right storage implementation
IStorage getStorage() => kIsWeb ? WebStorage() : MobileStorage();
