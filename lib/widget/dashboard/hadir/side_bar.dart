// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/model/user.dart';
import 'package:laporbos/screens/auth/login.dart';
import 'package:laporbos/screens/dashboard/hadir/absen_masuk.dart';
import 'package:laporbos/screens/dashboard/hadir/absen_pulang.dart';
import 'package:laporbos/screens/dashboard/hadir/daftar_absen.dart';
import 'package:laporbos/screens/dashboard/hadir/hadirbos.dart';
import 'package:laporbos/screens/dashboard/superAdmin/petugas/daftar_petugas.dart';
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
  int index_color = 0;
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
        // Dapatkan UserProvider menggunakan konteks
        final userProvider = context.read<UserProvider>();
        userProvider.setUser(userData);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    return Drawer(
      child: Material(
        color: Colors.deepOrange.shade50,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 65, 25, 0).w,
          child: Column(
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/a.jpeg',
                      width: 70.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (userProvider.user != null)
                        Text(
                          userProvider.user!.officerName,
                          style:
                              TextStyle(fontSize: 15.sp, color: Colors.black),
                        ),
                      SizedBox(height: 5.h),
                      if (userProvider.user != null)
                        Text(
                          userProvider.user!.officerID,
                          style:
                              TextStyle(fontSize: 15.sp, color: Colors.black),
                        ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 30.h),
              Divider(
                thickness: 1,
                height: 10.h,
                color: Colors.black,
              ),
              SizedBox(height: 30.h),
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
              SizedBox(height: 30.h),
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
              SizedBox(height: 30.h),
              DrawerItem(
                name: 'Absen Masuk',
                icon: Icons.message_outlined,
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
              SizedBox(height: 30.h),
              DrawerItem(
                name: 'Absen Keluar',
                icon: Icons.favorite_outline,
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
              SizedBox(height: 30.h),
              Divider(
                thickness: 1,
                height: 10.h,
                color: Colors.black,
              ),
              SizedBox(height: 30.h),
              DrawerItem(
                name: 'Setting',
                icon: Icons.settings,
                onTap: () {},
              ),
              SizedBox(height: 30.h),
              DrawerItem(
                name: 'Log out',
                icon: Icons.logout,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
