import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:laporbos/model/user.dart';

class UserService {
  static Future<UserModel?> fetchUserData(String token) async {
    final url = Uri.parse('http://192.168.48.180:8000/api/me');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> userDataList = json.decode(response.body);

        if (userDataList.isNotEmpty) {
          final Map<String, dynamic> userData = userDataList[0];
          return UserModel.fromJson(userData);
        }
      }
    } catch (e) {
      print('Error in UserService: $e');
    }

    return null;
  }
}
