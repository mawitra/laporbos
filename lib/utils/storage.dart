// ignore_for_file: unused_import

import 'package:laporbos/model/attendanceIn.dart';
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

  static Future<bool> hasUserSubmittedAttendanceToday(String officerId) async {
    DateTime now = DateTime.now();
    String formattedDate = "${now.year}-${now.month}-${now.day}";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastAttendanceDate =
        prefs.getString('lastAttendanceDate_$officerId');

    return lastAttendanceDate == formattedDate;
  }
}
