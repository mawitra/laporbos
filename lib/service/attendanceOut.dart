// ignore_for_file: unused_import, duplicate_import, file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:laporbos/config.dart';
import 'package:laporbos/model/attendance.dart';
import 'package:laporbos/model/attendanceIn.dart';

class AttendanceOutService {
  Future<AttendanceData> attendanceOut(
    String custId,
    String officerId,
    String officerName,
    String locQR,
    double latitude,
    double longitude,
    String pict,
    String token,
  ) async {
    final String apiUrl = "${ApiConfig.baseUrl}/api/attendance/out";

    // Create a map with the request parameters
    Map<String, dynamic> requestBody = {
      'cust_id': custId,
      'officer_id': officerId,
      'officer_name': officerName,
      'loc_qr': locQR,
      'latitude': latitude,
      'longitude': longitude,
      'pict': pict,
    };

    // Encode the request body to JSON
    String jsonBody = json.encode(requestBody);

    // Make the POST request
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      AttendanceData attendanceData = AttendanceData.fromJson(responseData);

      return attendanceData;
    } else {
      throw Exception('Failed to post attendance data');
    }
  }
}
