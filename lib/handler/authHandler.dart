// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:laporbos/service/AuthService.dart';

class AuthHandler {
  final AuthService authService = AuthService();

  Future<void> handleLogin(
      BuildContext context, String username, String password) async {
    try {
      await authService.login(username, password);
      // Tindakan setelah berhasil login, misalnya navigasi ke layar beranda
      Navigator.pushReplacementNamed(context, '/dashboard/home');
    } catch (e) {
      // Tindakan jika login gagal, misalnya menampilkan pesan kesalahan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Login gagal. Periksa kembali username dan password Anda.'),
        ),
      );
    }
  }
}
