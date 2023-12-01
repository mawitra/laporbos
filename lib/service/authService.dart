// ignore_for_file: file_names, unused_import

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:laporbos/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<Map<String, dynamic>?> login(String username, String password) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/api/login');

    try {
      final response = await http.post(
        url,
        body: {
          'username': username,
          'password': password,
        },
      ).timeout(const Duration(seconds: 3));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print('Error in AuthService: $e');
    }
    return null;
  }
}
