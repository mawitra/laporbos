// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:laporbos/model/attendance.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AttendanceService {
  Future<List<AttendanceModel>> getAllAttendanceData(
      String officerID, String token) async {
    final url =
        Uri.parse('http://192.168.18.158:8000/api/attendaceByUser/$officerID');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final dynamic decodedData = json.decode(response.body);

        if (decodedData is List) {
          return decodedData
              .map((data) => AttendanceModel.fromJson(data))
              .toList();
        } else {
          print('moshow');
        }
      }
    } catch (e) {
      print('Error in getAllAttendanceData: $e');
    }
    return [];
  }
}
