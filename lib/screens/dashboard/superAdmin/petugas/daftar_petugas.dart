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

class _DaftarPetugasState extends State<DaftarPetugas> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
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
            if (index == 0) {
              // Check if "Pelanggan" icon is clicked
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    HomeSuperAdmin(), // Navigate to the login screen
              ));
            } else if (index == 1) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ListCustomer(), // Navigate to the login screen
              ));
            } else if (index == 3) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    DaftarLaporan(), // Navigate to the login screen
              ));
            } else {
              setState(() {
                _currentIndex = index;
              });
            }
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
              ),
              child: Text(
                'Menu Pilihan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                // Add action when Dashboard menu is clicked
              },
            ),
            ListTile(
              title: Text('Customers'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ListCustomer(),
                ));
              },
            ),
            ListTile(
              title: Text('Officers'),
              onTap: () {
                // Add action when Officers menu is clicked
              },
            ),
            ListTile(
              title: Text('Reports'),
              onTap: () {
                // Add action when Reports menu is clicked
              },
            ),
          ],
        ),
      ),
    );
  }
}
