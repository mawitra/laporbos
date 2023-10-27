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

  static Future<void> saveOfficerID(String officerID) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('officerID', user!.officerID);
  }

  static Future<String?> getOfficerID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('officerID');
  }
}
