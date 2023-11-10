// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, unused_import, unused_local_variable
import 'package:flutter/material.dart';
import 'package:laporbos/model/auth.dart';
import 'package:laporbos/screens/dashboard/hadir/hadirbos.dart';
import 'package:laporbos/screens/dashboard/superAdmin/home.dart';
import 'package:laporbos/service/AuthService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:laporbos/widget/dashboard/bottomnavigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHandler {
  final BuildContext context;
  AuthHandler(this.context);

  Future<void> handleLogin(String username, String password) async {
    final authService = AuthService();
    final response = await authService.login(username, password);
    if (response != null) {
      final loginResponse = LoginModel.fromJson(response);
      final token = loginResponse.accessToken;
      final expiresIn = loginResponse.expiresIn;
      await saveTokenToSharedPreferences(token!);
      await saveExpiresInToSharedPreferences(expiresIn);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Bottom(
          initialIndex: 0,
          onIndexChanged: (int newIndex) {},
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed. Please check your credentials.'),
        ),
      );
    }
  }

  Future<void> saveTokenToSharedPreferences(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', accessToken);
  }

  Future<void> saveExpiresInToSharedPreferences(int? expiresIn) async {
    final prefs = await SharedPreferences.getInstance();
    if (expiresIn != null) {
      prefs.setInt('expires_in', expiresIn);
    }
  }
}
