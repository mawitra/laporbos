// attendance_qr_handler.dart
import 'package:laporbos/model/attendanceqr.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AttendanceQRService {
  static Future<List<AttendanceQRModel>> validateQRCode(
      String custId, String locQR, String token) async {
    final String apiUrl = "http://192.168.18.158:8000/api/attendance/qr";

    final Map<String, String> requestBody = {
      "cust_id": custId,
      "loc_qr": locQR,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode(requestBody),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final dynamic jsonResponse = json.decode(response.body);

      if (jsonResponse is List) {
        // If the response is a list, map it to the model
        return jsonResponse
            .map((data) => AttendanceQRModel.fromJson(data))
            .toList();
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load QR validation data');
    }
  }
}
