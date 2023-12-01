// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_import, unnecessary_nullable_for_final_variable_declarations, prefer_const_declarations, use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/model/user.dart';
import 'package:laporbos/screens/auth/login.dart';
import 'package:laporbos/service/userService.dart';
import 'package:laporbos/utils/greeting.dart';
import 'package:laporbos/utils/storage.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late String greeting = GreetingUtil.getGreetingMessage();
  UserModel? user;
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    _loadUserData();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  _loadUserData() async {
    final String? authToken = await StorageUtil.getToken();
    if (authToken != null) {
      final UserModel? userData = await UserService.fetchUserData(authToken);

      if (_isMounted) {
        final userProvider = context.read<UserProvider>();
        userProvider.setUser(userData);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 120.h,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                ).r,
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 35.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (userProvider.user != null)
                          Text(
                            'Haii, ${userProvider.user!.officerName}', // Access officerName from the user object
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 30.h,
          left: 20.w,
          child: Container(
            height: 135.h,
            width: 320.w,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColor.secondColor,
                ),
              ],
              color: Colors.brown.shade400,
              borderRadius: BorderRadius.circular(15).r,
            ),
            child: Container(
              padding: EdgeInsets.only(
                left: 10.w,
                top: 10.h,
                // right: 14.w,
                bottom: 20.h,
              ),
              // margin: EdgeInsets.only(left: 10.w, right: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Selamat Datang !",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Di Aplikasi Hadir ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      Text(
                                        "BossQue.",
                                        style: TextStyle(
                                          color: AppColor.bekColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Container(
                                    height: 2.h,
                                    width: 170.w,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Silahkan lakukan absensi hari ini.",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    DateFormat('EEEE, d MMMM y', 'id_ID')
                                        .format(DateTime.now()),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Image(
                                width: 100.w,
                                height: 100.h,
                                image: AssetImage(
                                  "assets/images/hadirbos.png",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
