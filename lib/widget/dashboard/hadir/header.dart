// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_import, unnecessary_nullable_for_final_variable_declarations, prefer_const_declarations

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

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    final String? authToken = await StorageUtil.getToken();
    if (authToken != null) {
      final UserModel? userData = await UserService.fetchUserData(authToken);

      if (userData != null) {
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
              height: 135.h,
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
                        // Text(
                        //   greeting,
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.w500,
                        //     fontSize: 17.sp,
                        //     color: Color.fromARGB(255, 255, 255, 255),
                        //   ),
                        // ),
                        if (userProvider.user != null)
                          Text(
                            'Haii, ${userProvider.user!.officerName}', // Access officerName from the user object
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
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
          top: 40.h,
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
              height: 200.h,
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selamat Datang !",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        'Lorem Ipsum has been the industrys',
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'standard dummy ever since the 1500s, ',
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        DateFormat('EEEE, d MMMM y').format(DateTime.now()),
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    // padding: EdgeInsets.only(left: ),
                    child: Image(
                      width: 100.w,
                      height: 100.h,
                      image: AssetImage('assets/images/hadirbos.png'),
                    ),
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
