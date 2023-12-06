// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, unused_import, unused_local_variable, non_constant_identifier_names, unnecessary_null_comparison, file_names
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laporbos/model/attendanceqr.dart';
import 'package:laporbos/model/user.dart';
import 'dart:convert';
import 'dart:async';

import 'package:laporbos/service/attendanceQrService.dart';
import 'package:laporbos/service/userService.dart';

class QRCodeHandler {
  final String custId;

  QRCodeHandler({required this.custId});

  Future<bool> handleQRCode(String qrCode, String token) async {
    try {
      UserModel? userData = await UserService.fetchUserData(token);

      if (userData != null) {
        String custIdFromUserData = userData.custID;

        List<AttendanceQRModel> qrData =
            await AttendanceQRService.validateQRCode(
                custIdFromUserData, qrCode, token);

        if (qrData.isNotEmpty) {
          print('Valid QR Code: ${qrData[0]}');
          return true;
        } else {
          print('Invalid QR Code');
          return false;
        }
      } else {
        print('Failed to fetch user data');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
