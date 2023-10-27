// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_import, prefer_final_fields, unused_field, non_constant_identifier_names, unused_local_variable, avoid_unnecessary_containers

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
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 243, 241),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors
                        .orange, // Atur warna oranye sesuai kebutuhan Anda
                    width: 2.0, // Atur lebar garis sesuai kebutuhan Anda
                  ),
                ),
                child: Row(
                  children: [
                    Column(
                      children: [Text('123'), Text('124')],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 243, 241),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors
                        .orange, // Atur warna oranye sesuai kebutuhan Anda
                    width: 2.0, // Atur lebar garis sesuai kebutuhan Anda
                  ),
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/b.jpeg',
                          width: 50,
                        )
                      ],
                    )
                  ],
                ),
              )
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
