// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, unused_import, unused_local_variable, non_constant_identifier_names, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laporbos/model/attendanceqr.dart';
import 'dart:convert';
import 'dart:async';
import 'package:laporbos/service/attendanceQrService.dart';
import 'package:laporbos/widget/dashboard/bottomnavigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceQrHandler {
  final BuildContext context;
  AttendanceQrHandler(this.context);
  Future<void> atttendanceQr(String custId, String locQR) async {
    final attendanceService = AttendanceQrService();
    final List<AttendanceQrModel> response =
        await attendanceService.fetchAttendanceData(custId, locQR);

    if (response.isNotEmpty) {
      final AttendanceQrModel loginResponse = response[0];
      final cust_Name = loginResponse.cust_name;
      final lockQr1 = loginResponse.loc_QR1;
      final lockQr2 = loginResponse.loc_QR2;

      await saveCustName(cust_Name!);
      await saveLockQr1(lockQr1!);
      await saveLockQr2(lockQr2!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal Membaca QrCode'),
        ),
      );
    }
  }

  Future<void> saveCustName(String custName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('Cust_Name', custName);
  }

  Future<void> saveLockQr1(String lockQr) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('loc_QR1', lockQr);
  }

  Future<void> saveLockQr2(String lockQr) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('loc_QR2', lockQr);
  }
}
