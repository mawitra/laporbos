// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_import

import 'package:flutter/material.dart';
import 'package:laporbos/color.dart';
// import 'package:laporbos/screens/dashboard/home.dart';
import 'package:laporbos/screens/dashboard/superAdmin/home.dart';

class ListCustomer extends StatefulWidget {
  const ListCustomer({super.key});

  @override
  State<ListCustomer> createState() => _ListCustomerState();
}

class _ListCustomerState extends State<ListCustomer> {
  int _currentIndex = 0;

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
          },
        ),
        backgroundColor: Colors.deepOrange
            .shade50, // Atur latar belakang AppBar menjadi transparan
        elevation: 0, // Hapus shadow dari AppBar
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
              icon: Icon(Icons.group, size: 25),
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
            if (index == 1) {
              // Check if "Pelanggan" icon is clicked
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ListCustomer(), // Navigate to the login screen
              ));
            } else {
              setState(() {
                _currentIndex = index;
              });
            }
          },
        ),
      ),
    );
  }
}
