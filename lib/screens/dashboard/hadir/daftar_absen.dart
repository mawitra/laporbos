// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_import, prefer_final_fields, unused_field, non_constant_identifier_names, unused_local_variable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/screens/dashboard/hadir/absenMasuk/absen_masuk.dart';
import 'package:laporbos/screens/dashboard/hadir/absenPulang/absen_pulang.dart';
import 'package:laporbos/screens/dashboard/hadir/daftarAbsensi/absensiHarini.dart';
import 'package:laporbos/screens/dashboard/hadir/daftarAbsensi/dataKehadiran.dart';

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
  bool isTapped = false;
  bool isTappedRekap = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.borderColor,
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    isTapped = !isTapped;
                  });
                  // Navigate to the desired page with a sliding animation and delay
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          AbsenHariIni(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset(0.0, 0.0);
                        const curve = Curves.easeInOutQuart;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                      transitionDuration: Duration(milliseconds: 500),
                      opaque: false,
                    ),
                  ).then((_) {
                    // Handle the state reset when returning from the next page
                    setState(() {
                      isTapped = false;
                    });
                  });
                },
                child: Container(
                  height: 70.h,
                  margin: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 40.h,
                  ),
                  decoration: BoxDecoration(
                    color: isTapped
                        ? AppColor.borderColor
                        : Color.fromARGB(255, 255, 250, 250),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.orange,
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/p.png',
                        width: 70.w,
                        height: 55.h,
                      ),
                      Container(
                        height: 55.h,
                        width: 2.w,
                        color: Colors.orange,
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Absensi Hari ini',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat('EEEE, d MMMM y', 'id_ID')
                                .format(DateTime.now()),
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigation logic for the second card
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          RekaDataAbsen(), // Adjust the destination page
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset(0.0, 0.0);
                        const curve = Curves.easeInOutQuart;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                      transitionDuration: Duration(milliseconds: 500),
                      opaque: false,
                    ),
                  );
                },
                child: Container(
                  // Second card
                  height: 70.h,
                  margin: EdgeInsets.only(
                    left: 20.h,
                    right: 20.h,
                    top: 10.w,
                  ),
                  decoration: BoxDecoration(
                    color: isTappedRekap
                        ? AppColor.borderColor
                        : Color.fromARGB(255, 255, 250, 250),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.orange,
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/p.png',
                        width: 70.w,
                        height: 55.h,
                      ),
                      Container(
                        height: 55.h,
                        width: 2.w,
                        color: Colors.orange,
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Rekap Data Kehadiran',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Data Keseluruhan Kehadiran ',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
