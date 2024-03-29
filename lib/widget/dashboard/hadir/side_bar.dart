// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable, unused_import, use_build_context_synchronously, library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/model/user.dart';
import 'package:laporbos/screens/auth/login.dart';
import 'package:laporbos/screens/dashboard/hadir/absenMasuk/absen_masuk.dart';
import 'package:laporbos/screens/dashboard/hadir/absenPulang/absen_pulang.dart';
import 'package:laporbos/screens/dashboard/hadir/daftar_absen.dart';
import 'package:laporbos/screens/dashboard/hadir/hadirbos.dart';

import 'package:laporbos/service/userService.dart';
import 'package:laporbos/utils/storage.dart';
import 'package:laporbos/widget/dashboard/bottomnavigation.dart';
import 'package:laporbos/widget/dashboard/hadir/drawer_item.dart';
import 'package:provider/provider.dart';
import '../../../provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  final Function(int) onIndexSelected;

  const CustomDrawer({Key? key, required this.onIndexSelected})
      : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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

      if (mounted) {
        if (userData != null) {
          // Dapatkan UserProvider menggunakan konteks
          final userProvider = context.read<UserProvider>();
          userProvider.setUser(userData);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    return Drawer(
      child: Material(
        color: AppColor.optionColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 65, 25, 0).w,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ClipOval(
                  //   child: Image.file(
                  //     File(userProvider.user!.nikPic),
                  //     width: 70.w,
                  //     height: 90.h,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 10.w,
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (userProvider.user != null)
                        Text(
                          userProvider.user!.officerName,
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      SizedBox(height: 5.h),
                      if (userProvider.user != null)
                        Text(
                          userProvider.user!.officerID,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20.h),
              Divider(
                thickness: 1,
                height: 10.h,
                color: Colors.black,
              ),
              SizedBox(height: 20.h),
              DrawerItem(
                name: 'Home',
                icon: Icons.home,
                onTap: () {
                  widget.onIndexSelected(0);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Bottom(
                      initialIndex: 0,
                      onIndexChanged: (int newIndex) {},
                    ),
                  ));
                },
              ),
              SizedBox(height: 20.h),
              DrawerItem(
                name: 'Daftar Absensi',
                icon: Icons.assignment_outlined,
                onTap: () {
                  widget.onIndexSelected(1);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Bottom(
                      initialIndex: 1,
                      onIndexChanged: (int newIndex) {},
                    ),
                  ));
                },
              ),
              SizedBox(height: 20.h),
              DrawerItem(
                name: 'Absen Masuk',
                icon: Icons.unarchive_outlined,
                onTap: () {
                  widget.onIndexSelected(2);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Bottom(
                      initialIndex: 2,
                      onIndexChanged: (int newIndex) {},
                    ),
                  ));
                },
              ),
              SizedBox(height: 20.h),
              DrawerItem(
                name: 'Absen pulang',
                icon: Icons.archive_outlined,
                onTap: () {
                  widget.onIndexSelected(3);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Bottom(
                      initialIndex: 3,
                      onIndexChanged: (int newIndex) {},
                    ),
                  ));
                },
              ),
              SizedBox(height: 20.h),
              Divider(
                thickness: 1,
                height: 10.h,
                color: Colors.black,
              ),
              // SizedBox(height: 30.h),
              // DrawerItem(
              //   name: 'Setting',
              //   icon: Icons.settings,
              //   onTap: () {},
              // ),
              SizedBox(height: 20.h),
              DrawerItem(
                name: 'Log out',
                icon: Icons.logout,
                onTap: () async {
                  await StorageUtil.clearToken();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Login(),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
