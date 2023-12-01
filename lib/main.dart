// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:laporbos/screens/auth/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporbos/provider/provider.dart';
import 'package:laporbos/widget/dashboard/bottomnavigation.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => UserProvider()),
            // ChangeNotifierProvider(create: (context) => EndShiffProvider()),
          ],
          child: MyApp(),
        ),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 850),
      builder: (context, child) {
        return MaterialApp(debugShowCheckedModeBanner: false, home: Login());
      },
    );
  }
}
