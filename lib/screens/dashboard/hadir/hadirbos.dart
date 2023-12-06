// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, unused_import, non_constant_identifier_names, prefer_const_constructors_in_immutables, prefer_const_declarations, unnecessary_null_comparison, avoid_print, avoid_unnecessary_containers, use_build_context_synchronously, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/model/attendance.dart';
import 'package:laporbos/model/user.dart';
import 'package:laporbos/screens/auth/login.dart';
import 'package:laporbos/service/attendance.dart';
import 'package:laporbos/service/userService.dart';
import 'package:laporbos/utils/storage.dart';
import 'package:laporbos/widget/dashboard/bottomnavigation.dart';
import 'package:laporbos/widget/dashboard/hadir/header.dart';
import 'package:laporbos/widget/dashboard/hadir/scroll_bar.dart';
import 'package:laporbos/widget/dashboard/hadir/side_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeHadirBos extends StatefulWidget {
  HomeHadirBos({Key? key}) : super(key: key);

  @override
  State<HomeHadirBos> createState() => _HomeHadirBosState();
}

class _HomeHadirBosState extends State<HomeHadirBos> {
  int index_color = 0;
  UserModel? user;
  List<AttendanceData> attendanceList = [];
  bool isLoading = true;
  bool _isMounted = false;
  String resultImagePath = '';
  String? selectedShiff;
  DateTime? selectedShiftStartTime;
  DateTime? selectedShiftEndTime;
  @override
  void initState() {
    super.initState();
    _isMounted = true;
    fetchUserAndAttendanceData();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  void adjustSelectedShiftTime() {
    switch (selectedShiff) {
      case "Shiff 1 jam 08:00 - 17:00":
        selectedShiftStartTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 8, 0, 0);
        selectedShiftEndTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 17, 0, 0);
        break;
      case "Shiff 2 jam 08:30 - 17:30":
        selectedShiftStartTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 8, 30, 0);
        selectedShiftEndTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 17, 30, 0);
        break;
      case "Shiff 3 jam 09:00 - 18:00":
        selectedShiftStartTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 9, 0, 0);
        selectedShiftEndTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 18, 0, 0);
        break;
      case "Shiff 4 jam 19:00 - 10:00":
        selectedShiftStartTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 19, 0, 0);
        selectedShiftEndTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 10, 0, 0);
        break;
      case "Shiff 5 jam 10:00 - 10:08":
        selectedShiftStartTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 10, 0, 0);
        selectedShiftEndTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 10, 0, 8);
        break;
      // Add other cases as needed
    }
  }

  Future<void> fetchUserAndAttendanceData() async {
    setState(() {
      isLoading = true;
    });

    final String? authToken = await StorageUtil.getToken();

    if (authToken != null) {
      try {
        user = await UserService.fetchUserData(authToken);

        String custId = user?.custID ?? '';
        String officerId = user?.officerID ?? '';

        AttendanceService attendanceService = AttendanceService();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? savedShift = prefs.getString('selectedShift');
        if (savedShift != null) {
          setState(() {
            selectedShiff = savedShift;
            adjustSelectedShiftTime();
          });
        }
        final List<AttendanceData> fetchedAttendanceData =
            await attendanceService.getAllAttendanceData(
                custId, officerId, authToken);

        if (_isMounted) {
          setState(() {
            attendanceList = fetchedAttendanceData;
            isLoading = false;
          });
        }
      } catch (e) {
        print('Error fetching data: $e');
        if (_isMounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
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
            onPressed: () async {
              await StorageUtil.clearToken();
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
      backgroundColor: AppColor.bekColor,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 165.h, child: Header()),
              SizedBox(height: 160.h, child: SpecialOffers()),
              Padding(
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
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: attendanceList
                            .where((attendance) => isToday(
                                DateTime.parse(attendance.attendanceDate)))
                            .isEmpty
                        ? [
                            isLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.orange),
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Belum ada absen hari ini",
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                          ]
                        : attendanceList
                            .where((attendance) => isToday(
                                DateTime.parse(attendance.attendanceDate)))
                            .map((attendance) {
                            DateTime attendanceDateTime =
                                DateTime.parse(attendance.attendanceDate);
                            adjustSelectedShiftTime();

                            DateTime expectedStartTime =
                                selectedShiftStartTime ?? DateTime.now();

                            DateTime expectedEndTime =
                                selectedShiftEndTime ?? DateTime.now();
                            bool isOnTimeOrEarlys =
                                !attendanceDateTime.isBefore(expectedStartTime);
                            bool isOnTimeOrEarly =
                                !attendanceDateTime.isAfter(expectedStartTime);

                            Duration latenessDuration = isOnTimeOrEarly
                                ? Duration()
                                : attendanceDateTime
                                    .difference(expectedStartTime);

                            Color textColor =
                                isOnTimeOrEarly ? Colors.green : Colors.red;

                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Card(
                                color: AppColor.optionColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Adjust the width as needed
                                      Image.file(
                                        File(attendance.attendancePic),
                                        width: 60.w,
                                        height: 70.h,
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(attendance.officerName),
                                                  Text(
                                                      'Tanggal: ${attendance.attendanceDate}'),
                                                  // Text('jam: ${selectedShiff}'),
                                                  Text(
                                                      'Status: ${attendance.status}'),
                                                  if (attendance.status ==
                                                          'In' &&
                                                      !isOnTimeOrEarlys)
                                                    Text(
                                                      'Absen Masuk jam ${DateFormat('HH:mm').format(DateTime.parse(attendance.attendanceDate))}',
                                                      style: TextStyle(
                                                          color: textColor),
                                                    ),
                                                  if (attendance.status ==
                                                          'Out' &&
                                                      !isOnTimeOrEarly)
                                                    Text(
                                                      'Absen Pulang jam ${DateFormat('HH:mm').format(DateTime.parse(attendance.attendanceDate))}',
                                                      style: TextStyle(
                                                          color: Colors.brown),
                                                    ),
                                                  if (!isOnTimeOrEarly &&
                                                      attendance.status !=
                                                          'Out')
                                                    Text(
                                                      'Terlambat: ${latenessDuration.inHours} jam ${latenessDuration.inMinutes % 60} menit',
                                                      style: TextStyle(
                                                          color: textColor),
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
                            );
                          }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
