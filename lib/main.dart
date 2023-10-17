// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:laporbos/screens/auth/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporbos/screens/auth/register.dart';
import 'package:laporbos/screens/dashboard/superAdmin/home.dart';

void main() {
  runApp(const MyApp());
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
          home: Login(),
        );
      },
    );
  }

  // Widget build(BuildContext context) {
  //   return ScreenUtilInit(
  //       designSize: const Size(360, 850),
  //       builder: (context, child) {
  //         return MultiProvider(
  //           providers: [
  //             ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
  //             ChangeNotifierProvider(create: (_) => DatabaseProvider()),
  //           ],
  //           child: MaterialApp(
  //             debugShowCheckedModeBanner: false,
  //             home: const Login(),
  //           ),
  //         );
  //       });
  // }
}
