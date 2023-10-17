// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_field, library_private_types_in_public_api, dead_code

import 'package:flutter/material.dart';
import 'package:laporbos/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporbos/screens/auth/login.dart';
import 'package:laporbos/screens/dashboard/superAdmin/customer/customer.dart';
import 'package:laporbos/screens/dashboard/superAdmin/laporan/daftar_laporan.dart';
import 'package:laporbos/screens/dashboard/superAdmin/petugas/daftar_petugas.dart';

class HomeSuperAdmin extends StatefulWidget {
  const HomeSuperAdmin({Key? key}) : super(key: key);

  @override
  _HomeSuperAdminState createState() => _HomeSuperAdminState();
}

class _HomeSuperAdminState extends State<HomeSuperAdmin> {
  int _currentIndex = 0;
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Container(
          color: Colors.deepOrange.shade50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Card(
                    elevation: 8,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Portal Super Admin',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          SizedBox(height: 5), // Jarak antara teks
                          Text(
                            'Selamat Siang Admin FC',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(height: 10), // Jarak antara teks
                          Text(
                            '16 Oktober 2023',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Expanded(
                    // child: SingleChildScrollView(
                    child: Container(
                      width: 360.w,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.r),
                          topRight: Radius.circular(40.r),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 30.h,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Customer",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 25.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Card(
                                      elevation: 8,
                                      // margin: EdgeInsets.all(),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.groups,
                                                color: Colors
                                                    .orange, // Warna ikon grup
                                                size: 50.sp, // Ukuran ikon grup
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Align(
                                              alignment: Alignment
                                                  .center, // Mengatur posisi teks ke tengah
                                              child: Text(
                                                "List Customer",
                                                style: TextStyle(
                                                  color: Colors
                                                      .orange, // Warna teks List Customer
                                                  fontSize: 10
                                                      .sp, // Ukuran teks List Customer
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Card(
                                      elevation: 8,
                                      // margin: EdgeInsets.all(),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment
                                                  .center, // Mengatur posisi ikon dan teks ke tengah
                                              child: Icon(
                                                Icons
                                                    .assignment_turned_in_rounded,
                                                color: Colors
                                                    .orange, // Warna ikon grup
                                                size: 50.sp, // Ukuran ikon grup
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Align(
                                              alignment: Alignment
                                                  .center, // Mengatur posisi teks ke tengah
                                              child: Text(
                                                "Activate Customer",
                                                style: TextStyle(
                                                  color: Colors
                                                      .orange, // Warna teks List Customer
                                                  fontSize: 10
                                                      .sp, // Ukuran teks List Customer
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Card(
                                      elevation: 8,
                                      // margin: EdgeInsets.all(),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment
                                                  .center, // Mengatur posisi ikon dan teks ke tengah
                                              child: Icon(
                                                Icons.group_off_sharp,
                                                color: Colors
                                                    .orange, // Warna ikon grup
                                                size: 50.sp, // Ukuran ikon grup
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Align(
                                              alignment: Alignment
                                                  .center, // Mengatur posisi teks ke tengah
                                              child: Text(
                                                "Deactivate",
                                                style: TextStyle(
                                                  color: Colors
                                                      .orange, // Warna teks List Customer
                                                  fontSize: 10
                                                      .sp, // Ukuran teks List Customer
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Officer",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 25.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Card(
                                      elevation: 8,
                                      // margin: EdgeInsets.all(),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment
                                                  .center, // Mengatur posisi ikon dan teks ke tengah
                                              child: Icon(
                                                Icons.groups,
                                                color: Colors
                                                    .orange, // Warna ikon grup
                                                size: 50.sp, // Ukuran ikon grup
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Align(
                                              alignment: Alignment
                                                  .center, // Mengatur posisi teks ke tengah
                                              child: Text(
                                                "List Customer",
                                                style: TextStyle(
                                                  color: Colors
                                                      .orange, // Warna teks List Customer
                                                  fontSize: 10
                                                      .sp, // Ukuran teks List Customer
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Card(
                                      elevation: 8,
                                      // margin: EdgeInsets.all(),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment
                                                  .center, // Mengatur posisi ikon dan teks ke tengah
                                              child: Icon(
                                                Icons.group_add_rounded,
                                                color: Colors
                                                    .orange, // Warna ikon grup
                                                size: 50.sp, // Ukuran ikon grup
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Align(
                                              alignment: Alignment
                                                  .center, // Mengatur posisi teks ke tengah
                                              child: Text(
                                                "Activate Officer",
                                                style: TextStyle(
                                                  color: Colors
                                                      .orange, // Warna teks List Customer
                                                  fontSize: 10
                                                      .sp, // Ukuran teks List Customer
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Card(
                                      elevation: 8,
                                      // margin: EdgeInsets.all(),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.group_remove_rounded,
                                                color: Colors.orange,
                                                size: 50.sp,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Deactivate",
                                                style: TextStyle(
                                                  color: Colors.orange,
                                                  fontSize: 10.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Laporan",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 25.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Card(
                                      elevation: 8,
                                      // margin: EdgeInsets.all(),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment
                                                  .center, // Mengatur posisi ikon dan teks ke tengah
                                              child: Icon(
                                                Icons.list_alt_rounded,
                                                color: Colors
                                                    .orange, // Warna ikon grup
                                                size: 50.sp, // Ukuran ikon grup
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Align(
                                              alignment: Alignment
                                                  .center, // Mengatur posisi teks ke tengah
                                              child: Text(
                                                "Lihat Laporan",
                                                style: TextStyle(
                                                  color: Colors
                                                      .orange, // Warna teks List Customer
                                                  fontSize: 15
                                                      .sp, // Ukuran teks List Customer
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Card(
                                      elevation: 8,
                                      // margin: EdgeInsets.all(),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment
                                                  .center, // Mengatur posisi ikon dan teks ke tengah
                                              child: Icon(
                                                Icons.my_library_books_sharp,
                                                color: Colors
                                                    .orange, // Warna ikon grup
                                                size: 50.sp, // Ukuran ikon grup
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Align(
                                              alignment: Alignment
                                                  .center, // Mengatur posisi teks ke tengah
                                              child: Text(
                                                "Laporan Petugas",
                                                style: TextStyle(
                                                  color: Colors
                                                      .orange, // Warna teks List Customer
                                                  fontSize: 15
                                                      .sp, // Ukuran teks List Customer
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 55,
        // color: Colors.deepOrange.shade50,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: AppColor.primaryColor, // Ganti sesuai kebutuhan
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.deepOrange.shade50,
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
            } else if (index == 2) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    DaftarPetugas(), // Navigate to the login screen
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
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Add action when Reports menu is clicked
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Login(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
