// ignore_for_file: unused_local_variable, use_build_context_synchronously, prefer_const_constructors, avoid_print, non_constant_identifier_names, unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>?> login(String username, String password) async {
    final url = Uri.parse('http://192.168.18.158:8000/api/login/officer');

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
        return {
          'access_token': responseData['access_token'],
          'expires_in': responseData['expires_in'],
        };
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }
}
