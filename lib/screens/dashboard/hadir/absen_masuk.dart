// ignore_for_file: prefer_const_constructors, unused_field, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/utils/scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
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
                      : Text(
                          'Scan QR terlebih dahulu'), // Pesan ketika belum discan
                ),
              ),
              SizedBox(height: 10),
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
            position = await _getGeoLocationPosition();
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
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (c) => UtilScanner()),
      );
      final placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      final place = placemarks[0];

      if (result != null && result is Barcode) {
        setState(() {
          isScanned = true;

          _result =
              'Data: ${result.code}\nLatitude: ${position.latitude}\nLongitude: ${position.longitude}\nAlamat: ${place.subLocality}, ${place.locality}, ${place.postalCode}, ';
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<Position> _getGeoLocationPosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        throw 'Location service Not Enabled';
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Location permission denied';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw 'Location permission denied forever, we cannot access';
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print("Error getting location: $e");
      throw e;
    }
  }
}
