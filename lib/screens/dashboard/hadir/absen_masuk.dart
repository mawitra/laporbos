// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_import, prefer_final_fields, unused_field, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/screens/dashboard/hadir/absen_pulang.dart';
import 'package:laporbos/screens/dashboard/hadir/daftar_absen.dart';
import 'package:laporbos/screens/dashboard/hadir/hadirbos.dart';
import 'package:laporbos/screens/dashboard/superAdmin/home.dart';
import 'package:laporbos/utils/scanner.dart';
import 'package:laporbos/widget/dashboard/bottomnavigation.dart';
import 'package:laporbos/widget/dashboard/hadir/drawer_item.dart';
import 'package:laporbos/widget/dashboard/hadir/side_bar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AbsenMasuk extends StatefulWidget {
  const AbsenMasuk({super.key});

  @override
  State<AbsenMasuk> createState() => _AbsenMasukState();
}

class _AbsenMasukState extends State<AbsenMasuk> {
  int index_color = 2;
  String _result = '';
  late GoogleMapController _controller;
  Position? _position;
  bool loading = false;

  LatLng _initialCameraPosition = LatLng(0, 0);

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
                Scaffold.of(context)
                    .openDrawer(); // Buka drawer saat tombol menu diklik
              },
            );
          },
        ),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
      ),
      // body: Center(
      //   child: Text(
      //     _result.isNotEmpty
      //         ? _result
      //         : 'Data', // Check if _result is not empty
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 20,
      //     ),
      //   ),
      // ),

      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                height: 300,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 243, 241),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.orange,
                    width: 2.0,
                  ),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Teks akan dimulai dari kiri
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Teks di tengah secara vertikal
                      children: [
                        Text(
                          _result.isNotEmpty
                              ? _result
                              : 'Data', // Check if _result is not empty
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
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
      // Buka scanner QR setelah mendapatkan lokasi
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (c) => UtilScanner()),
      );
      final placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      final place = placemarks[0];

      if (result != null && result is Barcode) {
        setState(() {
          _result =
              'Data: ${result.code}\nLatitude: ${position.latitude}\nLongitude: ${position.longitude}\nAlamat: ${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country} ';
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

//getLatLong
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

      // Continue accessing the device's position
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print("Error getting location: $e");
      throw e;
    }
  }
}
