// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:laporbos/model/attendanceqr.dart';

class AttendanceQrService {
  Future<List<AttendanceQrModel>> fetchAttendanceData(
      String custId, String locQR) async {
    final url = Uri.parse('http://192.168.18.158:8000/api/attendance/qr');

    try {
      final response = await http.post(
        url,
        body: {
          'cust_id': custId,
          'loc_qr': locQR,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => AttendanceQrModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load attendance data');
      }
    } catch (e) {
      print('Error in getAllAttendanceData: $e');
    }
    return [];
  }
}
