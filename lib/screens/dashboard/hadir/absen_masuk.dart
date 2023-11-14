// ignore_for_file: prefer_const_constructors, unused_field, non_constant_identifier_names, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/utils/getGeolocation.dart';
import 'package:laporbos/utils/scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:laporbos/utils/storage.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../widget/dashboard/hadir/side_bar.dart';

class AbsenMasuk extends StatefulWidget {
  const AbsenMasuk({super.key});

  @override
  State<AbsenMasuk> createState() => _AbsenMasukState();
}

class _AbsenMasukState extends State<AbsenMasuk> {
  int index_color = 2;
  String _result = '';
  final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
  Position? currentPosition;
  bool isScanned = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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
              SizedBox(height: 20),
              Container(
                height: 400.h,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 243, 241),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.orange,
                    width: 2.0,
                  ),
                ),
                child: Center(
                  child: isScanned // Periksa isScanned
                      ? OpenStreetMapSearchAndPick(
                          center: LatLong(
                            currentPosition!.latitude,
                            currentPosition!.longitude,
                          ),
                          buttonColor: AppColor.primaryColor,
                          onPicked: (pickedData) {
                            // ...
                          },
                        )
                      : Text('Scan QR terlebih dahulu'),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 243, 241),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.orange,
                    width: 2.0,
                  ),
                ),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 280.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Alamat',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            // Display the scanned address here
                            Text(
                              isScanned ? _result : 'Scan QR terlebih dahulu',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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

  Future<void> _openScanner(Position position) async {
    try {
      final authToken = await StorageUtil.getToken();
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (c) => ScannerUtils(
                  authToken: authToken!,
                )),
      );
      final placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      final place = placemarks[0];

      if (result != null && result is Barcode) {
        setState(() {
          isScanned = true;

          _result =
              'Alamat Lengkap: Jalan ${place.subLocality}, ${place.thoroughfare}, RT/RW ${place.subThoroughfare}/${place.thoroughfare}, Kelurahan ${place.subAdministrativeArea}, Kota ${place.locality}, Provinsi ${place.administrativeArea}, Kode Pos ${place.postalCode}, Negara ${place.country}';
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error: $e");
    }
  }
}
