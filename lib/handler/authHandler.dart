// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, unused_import

import 'package:flutter/material.dart';
import 'package:laporbos/screens/dashboard/hadir/hadirbos.dart';
import 'package:laporbos/screens/dashboard/superAdmin/home.dart';
import 'package:laporbos/service/AuthService.dart';
// import 'package:laporbos/screens/dashboard/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:laporbos/widget/dashboard/bottomnavigation.dart';

class AuthHandler {
  final BuildContext context;

  String? authToken; // Store the access token
  DateTime? tokenExpirationTime; // Store the expiration time
  // Timer? tokenRefreshTimer; // Timer for redirecting after token expiration

  AuthHandler(this.context);

  Future<void> handleLogin(String username, String password) async {
    final url = Uri.parse('http://192.168.43.221:8000/api/login');

    try {
      final response = await http.post(
        url,
        body: {
          'username': username,
          'password': password,
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        authToken = responseData['access_token'];
        final expiresIn = responseData['expires_in'];
        tokenExpirationTime = DateTime.now().add(
          Duration(seconds: expiresIn),
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Bottom(),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please check your credentials.'),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
  }
}
