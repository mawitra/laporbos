// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_import, prefer_final_fields, unused_field, non_constant_identifier_names, unused_local_variable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/screens/dashboard/hadir/absen_masuk.dart';
import 'package:laporbos/screens/dashboard/hadir/absen_pulang.dart';
import 'package:laporbos/screens/dashboard/hadir/hadirbos.dart';
import 'package:laporbos/screens/dashboard/superAdmin/home.dart';
import 'package:laporbos/widget/dashboard/bottomnavigation.dart';
import 'package:laporbos/widget/dashboard/hadir/drawer_item.dart';
import 'package:laporbos/widget/dashboard/hadir/side_bar.dart';

class DaftarAbsen extends StatefulWidget {
  const DaftarAbsen({super.key});

  @override
  State<DaftarAbsen> createState() => _DaftarAbsenState();
}

class _DaftarAbsenState extends State<DaftarAbsen> {
  int index_color = 1;

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
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        title: Text(
          "Hadir BossQue",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                height: 70,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 243, 241),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.orange,
                    width: 2.0,
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 3),
                    Image.asset(
                      'assets/icons/p.png', // Ganti dengan path gambar Anda
                      width: 70,
                      height: 55,
                    ),
                    SizedBox(width: 3), // Jarak antara ikon dan elemen teks
                    Container(
                      height:
                          55, // Sesuaikan tinggi garis sesuai kebutuhan Anda
                      width: 2, // Lebar garis vertikal
                      color: Colors.orange,
                    ),
                    SizedBox(width: 10), // Jarak antara garis dan elemen teks
                    Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Teks akan dimulai dari kiri
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Teks di tengah secara vertikal
                      children: [
                        Text(
                          'Absensi Hari ini',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('EEEE, d MMMM y', 'id_ID')
                              .format(DateTime.now()),
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 243, 241),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.orange,
                    width: 2.0,
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 3),
                    Image.asset(
                      'assets/icons/p.png',
                      width: 70,
                      height: 55,
                    ),
                    SizedBox(width: 3), // Jarak antara ikon dan elemen teks
                    Container(
                      height:
                          55, // Sesuaikan tinggi garis sesuai kebutuhan Anda
                      width: 2, // Lebar garis vertikal
                      color: Colors.orange,
                    ),
                    SizedBox(width: 10), // Jarak antara garis dan elemen teks
                    Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Teks akan dimulai dari kiri
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Teks di tengah secara vertikal
                      children: [
                        Text(
                          'Masuk Terlambat',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('EEEE, d MMMM y', 'id_ID')
                              .format(DateTime.now()),
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 243, 241),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.orange,
                    width: 2.0,
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 3),
                    Image.asset(
                      'assets/icons/p.png', // Ganti dengan path gambar Anda
                      width: 70,
                      height: 55,
                    ),
                    SizedBox(width: 3), // Jarak antara ikon dan elemen teks
                    Container(
                      height:
                          55, // Sesuaikan tinggi garis sesuai kebutuhan Anda
                      width: 2, // Lebar garis vertikal
                      color: Colors.orange,
                    ),
                    SizedBox(width: 10), // Jarak antara garis dan elemen teks
                    Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Teks akan dimulai dari kiri
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Teks di tengah secara vertikal
                      children: [
                        Text(
                          'Rekap Data Kehadiran',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Data Keseluruhan Kehadiran ',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 243, 241),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.orange,
                    width: 2.0,
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 3),
                    Image.asset(
                      'assets/icons/p.png', // Ganti dengan path gambar Anda
                      width: 70,
                      height: 55,
                    ),
                    SizedBox(width: 3), // Jarak antara ikon dan elemen teks
                    Container(
                      height:
                          55, // Sesuaikan tinggi garis sesuai kebutuhan Anda
                      width: 2, // Lebar garis vertikal
                      color: Colors.orange,
                    ),
                    SizedBox(width: 10), // Jarak antara garis dan elemen teks
                    Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Teks akan dimulai dari kiri
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Teks di tengah secara vertikal
                      children: [
                        Text(
                          'Keterangan Ketidakhadiran',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Sakit | Izin | Alpa',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
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
}
