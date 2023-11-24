// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_import, prefer_final_fields, unused_field, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/model/attendance.dart';

import 'package:laporbos/screens/dashboard/hadir/daftar_absen.dart';
import 'package:laporbos/screens/dashboard/hadir/hadirbos.dart';
import 'package:laporbos/screens/dashboard/superAdmin/home.dart';
import 'package:laporbos/service/attendanceOut.dart';
import 'package:laporbos/service/userService.dart';
import 'package:laporbos/utils/getGeolocation.dart';
import 'package:laporbos/utils/scanner.dart';
import 'package:laporbos/utils/storage.dart';
import 'package:laporbos/widget/dashboard/bottomnavigation.dart';
import 'package:laporbos/widget/dashboard/hadir/drawer_item.dart';
import 'package:laporbos/widget/dashboard/hadir/side_bar.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AbsenPulang extends StatefulWidget {
  const AbsenPulang({super.key});

  @override
  State<AbsenPulang> createState() => _AbsenPulangState();
}

class _AbsenPulangState extends State<AbsenPulang> {
  late SharedPreferences _prefs;

  int index_color = 2;
  String _result = '';
  final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
  Position? currentPosition;
  bool isScanned = false;
  bool isSubmitting = false;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _initializeSharedPreferences();
  }

  Future<void> _getCurrentLocation() async {
    try {
      currentPosition = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      print("Error getting current location: $e");
    }
  }

  Future<void> _openScanner(Position position) async {
    try {
      final authToken = await StorageUtil.getToken();
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (c) => ScannerUtils(
            authToken: authToken!,
          ),
        ),
      );
      final placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      final place = placemarks[0];

      if (result != null && result is Barcode) {
        setState(() {
          isScanned = true;

          _result =
              '${place.subLocality}, ${place.thoroughfare}, ${place.subAdministrativeArea}, ${place.locality}, Provinsi ${place.administrativeArea}, Kode Pos ${place.postalCode}, Negara ${place.country}';
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool _getAttendanceStatus() {
    // Mendapatkan tanggal saat ini dalam format yyyy-MM-dd
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Mengecek apakah ada data absensi pada tanggal tersebut
    return _prefs.getBool(currentDate) ?? false;
  }

  Future<void> _setAttendanceStatus() async {
    // Mendapatkan tanggal saat ini dalam format yyyy-MM-dd
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Menyimpan status absensi pada tanggal tersebut
    await _prefs.setBool(currentDate, true);
  }

  Future<void> attendanceOutData() async {
    final String? authToken = await StorageUtil.getToken();

    if (authToken != null) {
      try {
        user = await UserService.fetchUserData(authToken);

        String custId = user?.custID ?? '';
        String officerId = user?.officerID ?? '';
        String officerName = user?.officerName ?? '';
        String locQR = "000DMC22091";
        String pict = "../IMGUP/Out.DMC.6282297371652.2022.11.02.10.47.49.jpg";

        AttendanceOutService attendanceService = AttendanceOutService();

        final AttendanceData fetchedAttendanceData =
            await attendanceService.attendanceOut(
                custId,
                officerId,
                officerName,
                locQR,
                currentPosition!.latitude,
                currentPosition!.longitude,
                pict,
                authToken);

        // await _setAttendanceStatus();
        print(fetchedAttendanceData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Absen pulang berhasil'),
            duration: Duration(seconds: 2),
          ),
        );
      } catch (e) {
        print('Error fetching data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Absen pulang gagal'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade50,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        title: Text(
          "Hadir BossQue",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 320.h,
                // margin: EdgeInsets.symmetric(horizontal: 20),

                child: Center(
                  child: isScanned
                      ? OpenStreetMapSearchAndPick(
                          center: LatLong(
                            currentPosition!.latitude,
                            currentPosition!.longitude,
                          ),
                          buttonColor: AppColor.primaryColor,
                          locationPinIconColor: AppColor.primaryColor,
                          locationPinText: 'My Location',
                          locationPinTextStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          onPicked: (pickedData) {},
                        )
                      : Text(
                          'Scan QR terlebih dahulu',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColor.optionColor,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 300.h),
                                // margin: EdgeInsets.symmetric(horizontal: 10),
                                width: 350.w,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.r),
                                    topRight: Radius.circular(10.r),
                                  ),
                                ),
                                child: Container(
                                  // Second card
                                  height: 70.h,
                                  margin: EdgeInsets.only(
                                    left: 20.h,
                                    right: 20.h,
                                    top: 10.w,
                                  ),
                                  decoration: BoxDecoration(
                                    //  color: Colors.fromARGB(255, 255, 250, 250),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.orange,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Rekap Data Kehadiran',
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Data Keseluruhan Kehadiran ',
                                            style: TextStyle(fontSize: 14.sp),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 10.h),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 20),
              //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              //   decoration: BoxDecoration(
              //     color: const Color.fromARGB(255, 255, 243, 241),
              //     borderRadius: BorderRadius.circular(10),
              //     border: Border.all(
              //       color: Colors.orange,
              //       width: 2.0.w,
              //     ),
              //   ),
              //   child: SizedBox(
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Container(
              //           constraints: BoxConstraints(
              //             maxWidth: 280.w,
              //           ),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(
              //                 'Alamat',
              //                 style: TextStyle(
              //                     fontSize: 15, fontWeight: FontWeight.bold),
              //               ),
              //               Text(
              //                 isScanned ? _result : 'Scan QR terlebih dahulu',
              //                 style: TextStyle(fontSize: 14),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // // ),
              // SizedBox(height: 10.h),
              // Visibility(
              //   visible: isScanned,
              //   child: ElevatedButton(
              //     onPressed: () async {
              //       if (!isSubmitting) {
              //         setState(() {
              //           isSubmitting = true;
              //         });
              //         await attendanceOutData();
              //       }
              //     },
              //     child: Text('Absen Pulang'),
              //     style: ElevatedButton.styleFrom(
              //       primary: AppColor.primaryColor,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.center_focus_strong,
        ),
        onPressed: () async {
          Position position;
          try {
            position = await GeolocationUtils.getGeoLocationPosition();
          } catch (e) {
            print("Error getting location: $e");
            return;
          }
          await _openScanner(position);
        },
      ),
      drawer: CustomDrawer(
        onIndexSelected: (int index) {
          setState(() {
            index_color = index;
          });
        },
      ),
    );
  }
}
