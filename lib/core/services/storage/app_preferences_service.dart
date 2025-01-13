/// Created by Abdullah on 25/8/24.
library;
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static final String _REMEMBER_ME_KEY = 'REMEMBER_ME';
  static String USER_NAME = 'USER_NAME';
  static String USER_EMAIL = 'USER_EMAIL';


  static Future<void> setRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_REMEMBER_ME_KEY, value);
  }

  static Future<bool?> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_REMEMBER_ME_KEY);
  }

  static Future<void> clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_REMEMBER_ME_KEY);
  }

  static Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
