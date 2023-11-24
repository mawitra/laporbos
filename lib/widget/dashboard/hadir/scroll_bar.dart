// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/screens/dashboard/hadir/daftarAbsensi/absensiHarini.dart';
import 'package:laporbos/screens/dashboard/hadir/daftarAbsensi/dataKehadiran.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Laporan',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          AbsenHariIni(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = 0.0;
                        const end = 1.0;
                        const curve = Curves.easeInOutQuart;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        var clipRectAnimation = animation.drive(tween);

                        return ClipRect(
                          child: Align(
                            alignment: Alignment.center,
                            heightFactor: clipRectAnimation.value,
                            child: child,
                          ),
                        );
                      },
                      transitionDuration: Duration(milliseconds: 500),
                      opaque: false,
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: AppColor.optionColor,
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    border: Border.all(
                      color: AppColor.primaryColor,
                      width: 1.0.w,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Image.asset(
                        'assets/icons/p.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Absen Hari ini",
                        style: TextStyle(
                          color: Colors.brown.shade400,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // SizedBox(
              //   width: 20.w,
              // ),
              // Container(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: 10.w,
              //   ),
              //   height: 100.h,
              //   decoration: BoxDecoration(
              //     color: const Color.fromARGB(255, 255, 243, 241),
              //     borderRadius: BorderRadius.all(Radius.circular(
              //       10.r,
              //     )),
              //     border: Border.all(
              //       color: AppColor.primaryColor,
              //       width: 1.0.w,
              //     ),
              //   ),
              //   child: Column(
              //     children: [
              //       SizedBox(
              //         height: 10.h,
              //       ),
              //       Image.asset(
              //         'assets/icons/p.png', // Ganti dengan path gambar yang sesuai
              //         width: 50.w, // Atur lebar sesuai kebutuhan
              //         height: 50.h, // Atur tinggi sesuai kebutuhan
              //       ),
              //       SizedBox(
              //         height: 10.h,
              //       ),
              //       Text(
              //         "Absen Terlambat",
              //         style: TextStyle(
              //           color: Colors.brown.shade400,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 15.sp,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   width: 20.w,
              // ),
              // Container(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: 10.w,
              //   ),
              //   height: 100.h,
              //   decoration: BoxDecoration(
              //     color: const Color.fromARGB(255, 255, 243, 241),
              //     borderRadius: BorderRadius.all(Radius.circular(
              //       10.r,
              //     )),
              //     border: Border.all(
              //       color: AppColor.primaryColor,
              //       width: 1.0.w,
              //     ),
              //   ),
              //   child: Column(
              //     children: [
              //       SizedBox(
              //         height: 10.h,
              //       ),
              //       Image.asset(
              //         'assets/icons/p.png', // Ganti dengan path gambar yang sesuai
              //         width: 50.w, // Atur lebar sesuai kebutuhan
              //         height: 50.h, // Atur tinggi sesuai kebutuhan
              //       ),
              //       SizedBox(
              //         height: 10.h,
              //       ),
              //       Text(
              //         "Ketidakhadiran",
              //         style: TextStyle(
              //           color: Colors.brown.shade400,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 15.sp,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                width: 20.w,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          RekaDataAbsen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = 0.0;
                        const end = 1.0;
                        const curve = Curves.easeInOutQuart;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        var clipRectAnimation = animation.drive(tween);

                        return ClipRect(
                          child: Align(
                            alignment: Alignment.center,
                            heightFactor: clipRectAnimation.value,
                            child: child,
                          ),
                        );
                      },
                      transitionDuration: Duration(milliseconds: 500),
                      opaque: false,
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: AppColor.optionColor,
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    border: Border.all(
                      color: AppColor.primaryColor,
                      width: 1.0.w,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Image.asset(
                        'assets/icons/p.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Rekap Kehadiran",
                        style: TextStyle(
                          color: Colors.brown.shade400,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Tambahkan Container di dalam Column
      ],
    );
  }
}
