// ignore_for_file: prefer_const_constructors, sort_child_properties_last, library_private_types_in_public_api, unused_import, prefer_const_literals_to_create_immutables

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporbos/color.dart';

class HomeSuperAdmin extends StatefulWidget {
  const HomeSuperAdmin({Key? key}) : super(key: key);

  @override
  _HomeSuperAdminState createState() => _HomeSuperAdminState();
}

class _HomeSuperAdminState extends State<HomeSuperAdmin> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(200),
      //   child: Row(
      //     children: [
      //       Expanded(
      //           child: Container(
      //         decoration: BoxDecoration(
      //           color: AppColor.borderColor,
      //         ),
      //       ))
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Text(
          "data",
          style: TextStyle(
            color: AppColor.primaryColor,
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
        ),
        child: Expanded(
          child: Row(
            children: [],
          ),
        ),
      )),

      // bottomNavigationBar: BottomAppBar(
      //   child: Container(
      //     padding: EdgeInsets.symmetric(
      //       horizontal: 20,
      //     ),
      //     height: 60,
      //     child: Row(
      //       children: [
      //         Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Icon(Icons.home, size: 40),
      //             Text("data"),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),

      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          Icons.home,
          Icons.dashboard,
          Icons.settings,
          Icons.person,
        ],
        activeIndex: _currentIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.defaultEdge,
        activeColor: AppColor.primaryColor,
        inactiveColor: Colors.black,
        splashColor: AppColor.primaryColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        iconSize: 30,
      ),
    );
  }
}
