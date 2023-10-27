// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/screens/dashboard/hadir/absen_masuk.dart';
import 'package:laporbos/screens/dashboard/hadir/absen_pulang.dart';
import 'package:laporbos/screens/dashboard/hadir/daftar_absen.dart';
import 'package:laporbos/screens/dashboard/hadir/hadirbos.dart';

class Bottom extends StatefulWidget {
  final int initialIndex;
  final Function(int) onIndexChanged; // Tambahkan properti callback

  const Bottom(
      {Key? key,
      required this.initialIndex,
      required this.onIndexChanged,
      String? authToken,
      DateTime? tokenExpirationTime})
      : super(key: key);

  @override
  State<Bottom> createState() => _BottomState(initialIndex);
}

class _BottomState extends State<Bottom> {
  int index_color;

  _BottomState(this.index_color);

  void onIndexChanged(int newIndex) {
    setState(() {
      index_color = newIndex;
    });
  }

  List<Widget> screenList = [
    HomeHadirBos(),
    DaftarAbsen(),
    AbsenMasuk(),
    AbsenPulang(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepOrange.shade100,
      body: screenList[index_color],
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
