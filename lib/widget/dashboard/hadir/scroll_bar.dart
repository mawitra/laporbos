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
                width: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                height: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(
                    6.r,
                  )),
                  border: Border.all(
                    color: Colors.brown.shade700,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      "Absen Hari ini",
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
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
                  horizontal: 20.w,
                ),
                height: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(
                    6.r,
                  )),
                  border: Border.all(
                    color: Color(0xffDDDDDD),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      "Absen Hari ini",
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
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
                  horizontal: 20.w,
                ),
                height: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(
                    6.r,
                  )),
                  border: Border.all(
                    color: Color(0xffDDDDDD),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      "Absen Hari ini",
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
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
                  horizontal: 20.w,
                ),
                height: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(
                    6.r,
                  )),
                  border: Border.all(
                    color: Color(0xffDDDDDD),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      "Absen Hari ini",
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
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
