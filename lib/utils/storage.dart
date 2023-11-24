import 'package:laporbos/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

UserModel? user;

class StorageUtil {
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', token);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('access_token');
  }
}
