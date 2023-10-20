// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/screens/dashboard/superAdmin/customer/customer.dart';
import 'package:laporbos/screens/dashboard/superAdmin/home.dart';
import 'package:laporbos/screens/dashboard/superAdmin/laporan/daftar_laporan.dart';

class DaftarPetugas extends StatefulWidget {
  const DaftarPetugas({super.key});

  @override
  State<DaftarPetugas> createState() => _DaftarPetugasState();
}

class _DaftarPetugasState extends State<DaftarPetugas>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 2;

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.deepOrange.shade50,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // Tambahkan aksi yang ingin Anda lakukan saat ikon tiga garis diklik
            // Misalnya, untuk membuka drawer
            Scaffold.of(context).openDrawer();
          },
        ),
        backgroundColor: Colors.deepOrange
            .shade50, // Atur latar belakang AppBar menjadi transparan
        elevation: 0, // Hapus shadow dari AppBar
      ),
      body: Center(
        // Untuk mengatur teks ke tengah
        child: Text(
          ' petugas',
          style: TextStyle(
            fontSize: 32, // Ukuran teks
            fontWeight: FontWeight.bold, // Ketebalan teks
          ),
        ),
      ),
    );
  }
}
