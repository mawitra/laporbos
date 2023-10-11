// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:laporbos/service/AuthService.dart';

class AuthHandler {
  final AuthService authService = AuthService();

  Future<void> handleLogin(
      BuildContext context, String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      // Menampilkan pesan jika username atau password kosong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Username dan password tidak boleh kosong.'),
        ),
      );
      return;
    }

    try {
      // Memanggil metode login dari AuthService
      await authService.login(username, password);

      // Jika login berhasil, navigasikan ke halaman beranda (misalnya '/home')
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      // Jika terjadi kesalahan, menampilkan pesan kesalahan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login gagal. Silakan periksa kredensial Anda.'),
        ),
      );
    }
  }
}
