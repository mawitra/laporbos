// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_import, prefer_final_fields, unused_field, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/screens/dashboard/hadir/absen_masuk.dart';
import 'package:laporbos/screens/dashboard/hadir/daftar_absen.dart';
import 'package:laporbos/screens/dashboard/hadir/hadirbos.dart';
import 'package:laporbos/screens/dashboard/superAdmin/home.dart';
import 'package:laporbos/utils/scanner.dart';
import 'package:laporbos/utils/storage.dart';
import 'package:laporbos/widget/dashboard/bottomnavigation.dart';
import 'package:laporbos/widget/dashboard/hadir/drawer_item.dart';
import 'package:laporbos/widget/dashboard/hadir/side_bar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AbsenPulang extends StatefulWidget {
  const AbsenPulang({super.key});

  @override
  State<AbsenPulang> createState() => _AbsenPulangState();
}

class _AbsenPulangState extends State<AbsenPulang> {
  int index_color = 3;
  String _result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade50,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context)
                    .openDrawer(); // Buka drawer saat tombol menu diklik
              },
            );
          },
        ),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          _result.isNotEmpty
              ? _result
              : 'Data', // Check if _result is not empty
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.center_focus_strong,
        ),
        onPressed: _openScanner, // Call the method without parentheses
      ),
      drawer: CustomDrawer(
        onIndexSelected: (int index) {
          setState(() {
            index_color = index;
          });
        },
      ),
    );
  }

  Future<void> _openScanner() async {
    final authToken = await StorageUtil.getToken();
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (c) => ScannerUtils(
                authToken: authToken!,
              )),
    );

    if (result != null && result is Barcode) {
      setState(() {
        _result = result.code!;
      });
    }
  }
}
