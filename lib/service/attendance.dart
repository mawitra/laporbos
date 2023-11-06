// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:laporbos/model/attendance.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AttendanceService {
  Future<List<AttendanceModel>> getAllAttendanceData(
      String officerID, String token) async {
    final url =
        Uri.parse('http://192.168.48.180:8000/api/attendaceByUser/$officerID');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> attendanceDataList = json.decode(response.body);
        return attendanceDataList
            .map((data) => AttendanceModel.fromJson(data))
            .toList();
      }
    } catch (e) {
      // Handle other errors, e.g., network errors
      print('Error in getAllAttendanceData: $e');
    }

    // Return an empty list in case of errors
    return [];
  }
}
