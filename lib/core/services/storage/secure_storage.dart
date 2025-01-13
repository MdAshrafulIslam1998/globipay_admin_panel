/// Created by Abdullah on 25/8/24.
library;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final _storage = const FlutterSecureStorage();

  static final String _TOKEN_KEY = 'userToken';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _TOKEN_KEY, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _TOKEN_KEY);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _TOKEN_KEY);
  }
}
