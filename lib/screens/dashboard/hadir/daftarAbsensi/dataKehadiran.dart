// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/model/attendance.dart';
import 'package:laporbos/model/user.dart';
import 'package:laporbos/service/attendance.dart';
import 'package:laporbos/service/userService.dart';
import 'package:laporbos/utils/storage.dart';

class RekaDataAbsen extends StatefulWidget {
  const RekaDataAbsen({super.key});

  @override
  State<RekaDataAbsen> createState() => _RekaDataAbsenState();
}

class _RekaDataAbsenState extends State<RekaDataAbsen> {
  UserModel? user;

  List<AttendanceData> attendanceList = [];
  bool isLoading = true;
  bool _isMounted = false;

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
            if (attendanceList.isEmpty) {
              showSnackbar(context);
              // You may want to return here to avoid executing the code below
            }
          });
        }
      }
    }
  }

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tidak ada data Rekap absensi'),
        duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text('Rekap Data Absen'),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: attendanceList.isEmpty
                  ? [
                      Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center children vertically
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                              ),
                              isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.orange),
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 65.w),
                                      child: Center(
                                        child: ListTile(
                                          title: Center(
                                            child: Text(
                                              'Belum ada data Rekap Absen',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ]
                  : [
                      ListCard(
                        attendanceList: attendanceList,
                        isLoading: isLoading,
                      ),
                      SizedBox(
                        height: 20.h,
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

  const ListCard({
    Key? key,
    required this.attendanceList,
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
      children: attendanceList.map((attendance) {
        DateTime attendanceDateTime = DateTime.parse(attendance.attendanceDate);

        DateTime expectedTime = DateTime(
          attendanceDateTime.year,
          attendanceDateTime.month,
          attendanceDateTime.day,
          9,
          0,
          0,
        );

        bool isOnTimeOrEarly = !attendanceDateTime.isAfter(expectedTime);

        Duration latenessDuration = isOnTimeOrEarly
            ? Duration()
            : attendanceDateTime.difference(expectedTime);

        Color textColor = isOnTimeOrEarly ? Colors.green : Colors.red;

        return Container(
          padding: EdgeInsets.only(
            left: 10.w,
            top: 7.h,
            bottom: 10.h,
          ),
          margin: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.h,
          ),
          height: 110.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15.r),
            ),
            border: Border.all(
              color: AppColor.primaryColor,
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/b.jpeg',
                      width: 60.w,
                      height: 70.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 10,
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
                        'Status: ${attendance.status == 'In' ? 'Masuk' : attendance.status}',
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
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
                          attendance.attendanceDate,
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 210.w,
                        ),
                        child: isOnTimeOrEarly
                            ? Text(
                                'Absen Masuk Tepat Waktu.',
                                style: TextStyle(color: textColor),
                              )
                            : Text(
                                'Terlambat: ${latenessDuration.inHours} jam ${latenessDuration.inMinutes % 60} menit',
                                style: TextStyle(color: textColor),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 40.w,
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
                                Container(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/images/b.jpeg', // Replace with the actual image path
                                    width: 90.w, // Adjust the width as needed
                                    height: 90.h, // Adjust the height as needed
                                    fit: BoxFit.cover,
                                  ),
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
                                              '${attendance.status == 'In' ? 'Masuk' : attendance.status}',
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
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
                                                maxWidth: 90.w,
                                              ),
                                              child: isOnTimeOrEarly
                                                  ? Text(
                                                      'Tepat Waktu',
                                                      style: TextStyle(
                                                          color: textColor),
                                                    )
                                                  : Text(
                                                      'Terlambat: ${latenessDuration.inHours} jam ${latenessDuration.inMinutes % 60} menit',
                                                      style: TextStyle(
                                                        color: textColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
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
                                            maxWidth: 90.w,
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
                                              Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: 110.w,
                                                ),
                                                child: Text(
                                                  attendance.longitude,
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColor.primaryColor,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.end,
                                                ),
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
                      margin: EdgeInsets.only(right: 12.w),
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
