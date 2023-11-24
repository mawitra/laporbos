// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:laporbos/config.dart';
import 'package:laporbos/model/attendance.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:laporbos/model/attendance1.dart';

class AttendanceService {
  Future<List<AttendanceData>> getAllAttendanceData(
      String custID, String officerID, String token) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/api/attendance');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'Cust_ID': custID, // Replace with actual custId if needed
          'Officer_ID': officerID,
        }),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print('Request Payload: ${json.encode({
            'Cust_ID': custID,
            'Officer_ID': officerID
          })}');
      print('API Response: ${response.body}');
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['Status'] == 'True') {
          List<dynamic> data = responseData['DataList'];

          List<AttendanceData> attendanceDataList = data
              .map((attendance) => AttendanceData.fromJson(attendance))
              .toList();

          return attendanceDataList;
        } else {
          throw Exception(
              'Failed to fetch attendance data. Status: ${responseData['Status']}');
        }
      } else {
        throw Exception(
            'Failed to fetch attendance data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getAllAttendanceData: $e');
      throw e;
    }
  }
}
