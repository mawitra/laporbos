import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  Future<void> login(String username, String password) async {
    final url = Uri.parse('http://localhost:8000/api/login/officer');
    final response = await http.post(
      url,
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      print('gg');
      // Login berhasil, Anda dapat melakukan tindakan sesuai dengan keberhasilan login
    } else {
      // Login gagal, Anda dapat menangani kesalahan di sini
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message']; // Pesan kesalahan dari API
      print('Login gagal: $errorMessage');
    }
  }
}
