import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:laporbos/model/attendanceQr.dart';

class AttendanceQrService {
  final String baseUrl =
      'http://192.168.1.155:8000/api/attendance/qr'; // Update with your API URL

  Future<AttendanceQrModel?> postAttendanceQr(
      String custId, String locQr) async {
    final url = Uri.parse('$baseUrl/attendanceQR');
    final response = await http.post(url, body: {
      'cust_id': custId,
      'loc_qr': locQr,
    });

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return AttendanceQrModel.fromJson(jsonData);
    } else {
      return null; // Handle error cases here
    }
  }
}
