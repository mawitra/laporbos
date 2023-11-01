// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, unused_import, non_constant_identifier_names, prefer_const_constructors_in_immutables, prefer_const_declarations, unnecessary_null_comparison, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:laporbos/color.dart';
import 'package:laporbos/handler/attendanceHandler.dart';
import 'package:laporbos/model/attendance.dart';
import 'package:laporbos/model/user.dart';
import 'package:laporbos/screens/auth/login.dart';
import 'package:laporbos/screens/dashboard/hadir/absen_masuk.dart';
import 'package:laporbos/screens/dashboard/hadir/absen_pulang.dart';
import 'package:laporbos/screens/dashboard/hadir/daftar_absen.dart';
import 'package:laporbos/service/attendance.dart';
import 'package:laporbos/service/userService.dart';
import 'package:laporbos/utils/storage.dart';
import 'package:laporbos/widget/dashboard/bottomnavigation.dart';
import 'package:laporbos/widget/dashboard/hadir/header.dart';
import 'package:laporbos/widget/dashboard/hadir/scroll_bar.dart';
import 'package:laporbos/widget/dashboard/hadir/side_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeHadirBos extends StatefulWidget {
  HomeHadirBos({Key? key}) : super(key: key);

  @override
  State<HomeHadirBos> createState() => _HomeHadirBosState();
}

class _HomeHadirBosState extends State<HomeHadirBos> {
  int index_color = 0;
  AttendanceModel? attendance;
  UserModel? user;
  List<AttendanceModel> attendanceList = [];

  @override
  void initState() {
    super.initState();
    fetchAttendanceData();
  }

  Future<void> fetchAttendanceData() async {
    final attendanceService = AttendanceService();
    final String? authToken = await StorageUtil.getToken();

    if (authToken != null) {
      user = await UserService.fetchUserData(authToken);
      if (user != null) {
        final allAttendanceData = await attendanceService.getAllAttendanceData(
            user!.officerID, authToken);

        print(allAttendanceData);

        setState(() {
          attendanceList = allAttendanceData;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout,
                color: const Color.fromARGB(255, 255, 255, 255)),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Login(),
              ));
            },
          ),
        ],
      ),
      drawer: CustomDrawer(
        onIndexSelected: (int index) {
          setState(() {
            index_color = index;
          });
        },
      ),
      backgroundColor: Colors.deepOrange.shade50,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 180.h, child: Header()),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 160.h, child: SpecialOffers()),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                            fontSize: 15.sp,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Lihat semua',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
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
              child: SizedBox(height: 10.h),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final attendance = attendanceList[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Card(
                      color: Color.fromARGB(255, 255, 233, 226),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0.r),
                      ),
                      child: ListTile(
                        leading: ClipOval(
                          child: Image.asset('assets/images/b.jpeg',
                              width: 50.w, height: 70.h),
                        ),
                        title: Text(attendance.officerName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tanggal: ${attendance.attdDate}'),
                            Text('Status: ${attendance.status}'),
                            Text('Absen Masuk Tepat Waktu.'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: attendanceList.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
