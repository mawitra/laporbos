// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_import, must_call_super

import 'package:flutter/material.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/screens/dashboard/home.dart';
// import 'package:laporbos/screens/dashboard/home.dart';
import 'package:laporbos/screens/dashboard/superAdmin/home.dart';
import 'package:laporbos/screens/dashboard/superAdmin/laporan/daftar_laporan.dart';
import 'package:laporbos/screens/dashboard/superAdmin/petugas/daftar_petugas.dart';

class HadirbosHome extends StatefulWidget {
  const HadirbosHome({super.key});

  @override
  State<HadirbosHome> createState() => _HadirbosHomeState();
}

class _HadirbosHomeState extends State<HadirbosHome>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 1;
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade50,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        backgroundColor: Colors.deepOrange.shade50,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Add a search bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    // Implement search functionality
                    // You can filter customerData based on the search value
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 55,
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            selectedItemColor: AppColor.primaryColor, // Ganti sesuai kebutuhan
            unselectedItemColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 25,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.group,
                  size: 25,
                ),
                label: "Pelanggan",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.groups, size: 25),
                label: "Petugas",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment_outlined, size: 25),
                label: "Laporan",
              ),
            ],
            onTap: (index) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeSuperAdmin(),
                  ));
              setState(() {
                _currentIndex = index;
              });
            }),
      ),
    );
  }
}
