// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_import, prefer_final_fields, unused_field, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
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
              icon: Icon(Icons.menu, color: Colors.black),
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
      drawer: CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 0;
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HomeHadirBos(),
                      ),
                    );
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.home,
                      size: 30,
                      color: index_color == 0
                          ? AppColor.primaryColor
                          : const Color.fromARGB(255, 0, 0, 0),
                    ),
                    Text(
                      'Beranda',
                      style: TextStyle(
                        fontSize: 12,
                        color: index_color == 0
                            ? AppColor.primaryColor
                            : const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 1;
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => DaftarAbsen(),
                      ),
                    );
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.assignment_outlined,
                      size: 30,
                      color: index_color == 1
                          ? AppColor.primaryColor
                          : const Color.fromARGB(255, 0, 0, 0),
                    ),
                    Text(
                      'Daftar Absen',
                      style: TextStyle(
                        fontSize: 12,
                        color: index_color == 1
                            ? AppColor.primaryColor
                            : const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 2;
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => AbsenMasuk(),
                      ),
                    );
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.drive_folder_upload,
                      size: 30,
                      color: index_color == 2
                          ? AppColor.primaryColor
                          : const Color.fromARGB(255, 5, 5, 5),
                    ),
                    Text(
                      'Absen Masuk',
                      style: TextStyle(
                        fontSize: 12,
                        color: index_color == 2
                            ? AppColor.primaryColor
                            : const Color.fromARGB(255, 5, 5, 5),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 3;
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => AbsenPulang(),
                      ),
                    );
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.archive_outlined,
                      size: 30,
                      color: index_color == 3
                          ? AppColor.primaryColor
                          : const Color.fromARGB(255, 10, 10, 10),
                    ),
                    Text(
                      'Absen Pulang',
                      style: TextStyle(
                        fontSize: 12,
                        color: index_color == 3
                            ? AppColor.primaryColor
                            : const Color.fromARGB(255, 10, 10, 10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
