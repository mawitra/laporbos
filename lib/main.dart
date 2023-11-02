// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laporbos/screens/auth/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporbos/screens/auth/register.dart';
import 'package:laporbos/screens/dashboard/hadir/hadirbos.dart';
import 'package:laporbos/screens/dashboard/superAdmin/home.dart';
import 'package:laporbos/provider/userProvider.dart';
import 'package:laporbos/widget/dashboard/bottomnavigation.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 850),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Bottom(
            initialIndex: 0,
            onIndexChanged: (int newIndex) {
              // Tambahkan logika yang sesuai di sini
            },
          ),
        );
      },
    );
  }
}
