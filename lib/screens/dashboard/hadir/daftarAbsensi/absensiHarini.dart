// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/model/attendance.dart';
import 'package:laporbos/model/user.dart';
import 'package:laporbos/service/attendance.dart';
import 'package:laporbos/service/userService.dart';
import 'package:laporbos/utils/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AbsenHariIni extends StatefulWidget {
  const AbsenHariIni({super.key});

  @override
  State<AbsenHariIni> createState() => _AbsenHariIniState();
}

class _AbsenHariIniState extends State<AbsenHariIni> {
  int index_color = 0;
  UserModel? user;

  List<AttendanceData> attendanceList = [];
  bool isLoading = true;
  bool _isMounted = false;
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

            // Check if there is no attendance for today
            if (attendanceList
                .where((attendance) =>
                    isToday(DateTime.parse(attendance.attendanceDate)))
                .isEmpty) {
              showSnackbar(context);
            }
          });
        }
      } catch (e) {
        print('Error fetching data: $e');

        if (_isMounted) {
          setState(() {
            isLoading = false;
            showSnackbar(context);
          });
        }
      }
    }
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
            DateTime.now().month, DateTime.now().day, 8, 3, 0);
        selectedShiftEndTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 17, 3, 0);
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

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tidak ada data Absensi.'),
        duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
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
        backgroundColor: AppColor.primaryColor,
        title: Text('Absen Hari Ini'),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: attendanceList
                      .where((attendance) =>
                          isToday(DateTime.parse(attendance.attendanceDate)))
                      .isEmpty
                  ? [
                      Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center children vertically
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.4.h,
                              ),
                              isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
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
                            ],
                          ),
                        ],
                      ),
                    ]
                  : [
                      ListCard(
                        attendanceList: attendanceList,
                        isLoading: isLoading,
                        selectedShiff: selectedShiff,
                        selectedShiftStartTime: selectedShiftStartTime,
                        selectedShiftEndTime: selectedShiftEndTime,
                      ),
                    ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListCard extends StatelessWidget {
  final List<AttendanceData> attendanceList;
  final bool isLoading;
  String? selectedShiff;
  DateTime? selectedShiftStartTime;
  DateTime? selectedShiftEndTime;

  ListCard({
    Key? key,
    required this.attendanceList,
    required this.selectedShiff,
    required this.selectedShiftStartTime,
    required this.selectedShiftEndTime,
    required this.isLoading,
  }) : super(key: key);

  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: attendanceList
          .where((attendance) =>
              isToday(DateTime.parse(attendance.attendanceDate)))
          .map((attendance) {
        DateTime attendanceDateTime = DateTime.parse(attendance.attendanceDate);

        DateTime expectedStartTime = selectedShiftStartTime ??
            DateTime
                .now(); // Use DateTime.now() as a fallback value or choose a default value

        DateTime expectedEndTime = selectedShiftEndTime ??
            DateTime
                .now(); // Use DateTime.now() as a fallback value or choose a default value

        bool isOnTimeOrEarly = !attendanceDateTime.isAfter(expectedStartTime);

        Duration latenessDuration = isOnTimeOrEarly
            ? Duration()
            : attendanceDateTime.difference(expectedStartTime);

        Color textColor = isOnTimeOrEarly ? Colors.green : Colors.red;
        return Container(
          padding: EdgeInsets.only(
            left: 10.w,
            right: 10.w,
            top: 10.h,
            bottom: 10.h,
          ),
          margin: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.h,
          ),
          height: 115.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15.r),
            ),
            border: Border.all(
              color: AppColor.primaryColor,
              width: 1.0.w,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.file(
                    File(attendance.attendancePic), // Use the actual file path
                    width: 70.w,
                    height: 90.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        attendance.officerName,
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Status: ${attendance.status == 'In' ? 'Masuk' : 'Pulang'}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 210.w,
                        ),
                        child: Text(
                          'Jam: ${DateFormat('HH:mm').format(DateTime.parse(attendance.attendanceDate))}',
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 210.w,
                        ),
                        child: Text(
                          DateFormat('EEEE, d MMMM y', 'id_ID').format(
                            DateTime.parse(attendance.attendanceDate),
                          ),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 210.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (attendance.status == 'In' && isOnTimeOrEarly)
                              Text(
                                'Absen Masuk Tepat Waktu.',
                                style: TextStyle(color: textColor),
                              ),
                            if (attendance.status == 'Out' && isOnTimeOrEarly)
                              Text(
                                'Absen Pulang jam ${DateFormat('HH:mm').format(DateTime.parse(attendance.attendanceDate))}',
                                style: TextStyle(color: Colors.brown),
                              ),
                            if (!isOnTimeOrEarly && attendance.status != 'Out')
                              Text(
                                'Terlambat: ${latenessDuration.inHours} jam ${latenessDuration.inMinutes % 60} menit',
                                style: TextStyle(color: textColor),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Informasi Absen Hari Ini",
                                      style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  height: 1.h,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                // Add the image below the black line
                                Image.file(
                                  File(attendance
                                      .attendancePic), // Use the actual file path
                                  width: 90.w,
                                  height: 90.h,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                            content: SizedBox(
                              width: 800.w, // Increase width
                              height: 250.h, // Increase height
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Nama",
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              attendance.officerName,
                                              style: TextStyle(
                                                color: AppColor.primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "No Officer",
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Container(
                                              constraints: BoxConstraints(
                                                maxWidth: 200.w,
                                              ),
                                              child: Text(
                                                attendance.officerId,
                                                style: TextStyle(
                                                  color: AppColor.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.sp,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.end,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Status Absen",
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '${attendance.status == 'In' ? 'Masuk' : attendance.status == 'Out' ? 'Pulang' : attendance.status}',
                                              style: TextStyle(
                                                color: AppColor.primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
                                        ),
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: 110.w,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "LocQR",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                attendance.locationQR,
                                                style: TextStyle(
                                                  color: AppColor.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.sp,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.end,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Tanggal",
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Container(
                                              constraints: BoxConstraints(
                                                maxWidth: 110.w,
                                              ),
                                              child: Text(
                                                attendance.attendanceDate,
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.primaryColor,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Keterangan",
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: 100.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  if (attendance.status ==
                                                          'In' &&
                                                      isOnTimeOrEarly)
                                                    Text(
                                                      'Absen Tepat Waktu.',
                                                      style: TextStyle(
                                                          color: textColor),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  if (attendance.status ==
                                                          'Out' &&
                                                      isOnTimeOrEarly)
                                                    Text(
                                                      'Absen Pulang jam ${DateFormat('HH:mm').format(DateTime.parse(attendance.attendanceDate))}',
                                                      style: TextStyle(
                                                          color: Colors.brown),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  if (!isOnTimeOrEarly &&
                                                      attendance.status !=
                                                          'Out')
                                                    Text(
                                                      'Terlambat: ${latenessDuration.inHours} jam ${latenessDuration.inMinutes % 60} menit',
                                                      style: TextStyle(
                                                          color: textColor),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.end,
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: 90.w,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Latitude",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: 110.w,
                                                ),
                                                child: Text(
                                                  attendance.latitude,
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColor.primaryColor,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: 200.w,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Longtitude",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                attendance.longitude,
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.primaryColor,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.end,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Close",
                                  style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 5.w, left: 5.w),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20.h,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
