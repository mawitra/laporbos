// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporbos/screens/auth/register.dart';

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
          home: Register(),
        );
      },
    );
  }
}
