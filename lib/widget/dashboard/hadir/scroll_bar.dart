// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporbos/color.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Laporan',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: 20.w,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                height: 100.h,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 243, 241),
                  borderRadius: BorderRadius.all(Radius.circular(
                    10.r,
                  )),
                  border: Border.all(
                    color: AppColor.primaryColor,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Image.asset(
                      'assets/icons/p.png', // Ganti dengan path gambar yang sesuai
                      width: 50.w, // Atur lebar sesuai kebutuhan
                      height: 50.h, // Atur tinggi sesuai kebutuhan
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
              SizedBox(
                width: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                height: 100.h,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 243, 241),
                  borderRadius: BorderRadius.all(Radius.circular(
                    10.r,
                  )),
                  border: Border.all(
                    color: AppColor.primaryColor,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Image.asset(
                      'assets/icons/p.png', // Ganti dengan path gambar yang sesuai
                      width: 50.w, // Atur lebar sesuai kebutuhan
                      height: 50.h, // Atur tinggi sesuai kebutuhan
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
              SizedBox(
                width: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                height: 100.h,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 243, 241),
                  borderRadius: BorderRadius.all(Radius.circular(
                    10.r,
                  )),
                  border: Border.all(
                    color: AppColor.primaryColor,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Image.asset(
                      'assets/icons/p.png', // Ganti dengan path gambar yang sesuai
                      width: 50.w, // Atur lebar sesuai kebutuhan
                      height: 50.h, // Atur tinggi sesuai kebutuhan
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
              SizedBox(
                width: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                height: 100.h,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 243, 241),
                  borderRadius: BorderRadius.all(Radius.circular(
                    10.r,
                  )),
                  border: Border.all(
                    color: AppColor.primaryColor,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Image.asset(
                      'assets/icons/p.png', // Ganti dengan path gambar yang sesuai
                      width: 50.w, // Atur lebar sesuai kebutuhan
                      height: 50.h, // Atur tinggi sesuai kebutuhan
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
              SizedBox(
                width: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                height: 100.h,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 243, 241),
                  borderRadius: BorderRadius.all(Radius.circular(
                    10.r,
                  )),
                  border: Border.all(
                    color: AppColor.primaryColor,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Image.asset(
                      'assets/icons/p.png', // Ganti dengan path gambar yang sesuai
                      width: 50.w, // Atur lebar sesuai kebutuhan
                      height: 50.h, // Atur tinggi sesuai kebutuhan
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
              SizedBox(
                width: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                height: 100.h,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 243, 241),
                  borderRadius: BorderRadius.all(Radius.circular(
                    10.r,
                  )),
                  border: Border.all(
                    color: AppColor.primaryColor,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Image.asset(
                      'assets/icons/p.png', // Ganti dengan path gambar yang sesuai
                      width: 50.w, // Atur lebar sesuai kebutuhan
                      height: 50.h, // Atur tinggi sesuai kebutuhan
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
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        // Tambahkan Container di dalam Column
      ],
    );
  }
}
