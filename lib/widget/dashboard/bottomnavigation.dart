// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/screens/dashboard/hadir/hadirbos.dart';
import 'package:laporbos/screens/dashboard/superAdmin/petugas/daftar_petugas.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int index_color = 0;
  List Screen = [
    HomeHadirBos(),
    DaftarPetugas(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade100,
      body: Screen[index_color],
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
