// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/screens/auth/login.dart';
import 'package:laporbos/screens/dashboard/hadir/absen_masuk.dart';
import 'package:laporbos/screens/dashboard/hadir/absen_pulang.dart';
import 'package:laporbos/screens/dashboard/hadir/daftar_absen.dart';
import 'package:laporbos/screens/dashboard/superAdmin/petugas/daftar_petugas.dart';
import 'package:laporbos/widget/dashboard/bottomnavigation.dart';
import 'package:laporbos/widget/dashboard/hadir/header.dart';
import 'package:laporbos/widget/dashboard/hadir/scroll_bar.dart';
import 'package:laporbos/widget/dashboard/hadir/side_bar.dart';

class HomeHadirBos extends StatefulWidget {
  HomeHadirBos({Key? key}) : super(key: key);

  @override
  State<HomeHadirBos> createState() => _HomeHadirBosState();
}

class _HomeHadirBosState extends State<HomeHadirBos> {
  int index_color = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

        title: Text(
          "Hadir BossQue", // Ganti dengan judul aplikasi Anda
          style: TextStyle(
              color: Colors.white,
              fontSize: 25 // Ganti warna teks sesuai kebutuhan Anda
              ),
        ),
        centerTitle: true, // Mengarahkan teks ke tengah AppBar
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout,
                color: const Color.fromARGB(255, 255, 255, 255)), // Ikon Logout
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Login(),
              ));
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      backgroundColor: Colors.deepOrange.shade50,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 180, child: Header()),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 160, child: SpecialOffers()),
            ),
            // SliverToBoxAdapter(
            //   child: IndexedStack(
            //     index: index_color,
            //     children: [
            //       HomeHadirBos(),
            //       DaftarPetugas(),
            //       // Tambahkan halaman Absen Masuk dan Absen Keluar di sini
            //     ],
            //   ),
            // ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Absen Terakhir',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Lihat semua',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 5), // Add some space above the card list
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final now = DateTime.now();
                  final formattedDate = "${now.year}-${now.month}-${now.day}";
                  final formattedTime =
                      "${now.hour}:${now.minute}:${now.second}";

                  return Card(
                    color: Colors.deepOrange.shade50,
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: ClipOval(
                            child: Image.asset('assets/images/b.jpeg',
                                width: 50, height: 50),
                          ),
                          title: const Text('Mada Dwi Saputra'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Tanggal: $formattedDate, Jam $formattedTime'),
                              Text('Absen Masuk Tepat Waktu.'),

                              // Text('Time: $formattedTime'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 5,
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
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
