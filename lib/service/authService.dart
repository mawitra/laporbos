import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  Future<void> login(String username, String password) async {
    final url = Uri.parse(
        'http://localhost:8000/api/login/officer'); // Ganti URL sesuai dengan URL login API Anda.

    try {
      final response = await http.post(
        url,
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Jika respons kode adalah 200, berarti login berhasil.
        // Anda dapat menangani respons sesuai kebutuhan, seperti menyimpan token autentikasi.
        final responseData = jsonDecode(response.body);
        final authToken =
            responseData['token']; // Contoh cara menyimpan token autentikasi.

        // Selain itu, Anda bisa melakukan tindakan lain seperti menyimpan data pengguna, dll.
      } else {
        // Jika respons kode adalah selain 200, berarti login gagal.
        // Anda bisa menangani pesan kesalahan dari API sesuai kebutuhan.
        final responseBody = jsonDecode(response.body);
        final errorMessage =
            responseBody['message']; // Pesan kesalahan dari API.

        throw Exception(
            errorMessage); // Anda bisa melempar kesalahan dengan pesan kesalahan dari API.
      }
    } catch (e) {
      // Tangani kesalahan jaringan atau kesalahan lainnya.
      throw Exception('Gagal melakukan login: $e');
    }
  }
}
