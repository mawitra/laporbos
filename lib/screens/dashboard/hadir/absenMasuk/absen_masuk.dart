// ignore_for_file: unused_import, unused_field, non_constant_identifier_names, unnecessary_null_comparison, unused_local_variable, use_key_in_widget_constructors, avoid_print, use_build_context_synchronously, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart'
    as google_maps;
import 'package:google_ml_kit/google_ml_kit.dart' as mlkit;
import 'package:intl/intl.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/model/attendance.dart';
import 'package:laporbos/model/user.dart';
import 'package:laporbos/provider/provider.dart';
import 'package:laporbos/service/attendanceIn.dart';
import 'package:laporbos/service/userService.dart';
import 'package:laporbos/utils/getGeolocation.dart';
import 'package:laporbos/utils/scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:laporbos/utils/storage.dart';
import 'package:laporbos/widget/dashboard/bottomnavigation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../widget/dashboard/hadir/side_bar.dart';

class AbsenMasuk extends StatefulWidget {
  const AbsenMasuk({Key? key});

  @override
  State<AbsenMasuk> createState() => _AbsenMasukState();
}

class _AbsenMasukState extends State<AbsenMasuk> {
  late SharedPreferences _prefs;
  late GoogleMapController mapController;
  late String locQR;
  int index_color = 2;
  String _result = '';
  final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
  Position? currentPosition;
  bool isScanned = false;
  bool isLoading = true;
  bool isSubmitting = false;
  late CameraController _cameraController;
  late mlkit.FaceDetector faceDetector;
  bool _isCameraInitialized = false;
  bool _isBackPressed = false;
  bool isImageCaptured = true;
  String resultImagePath = '';
  bool isPhotoTaken = false;
  String? selectedShiff;
  DateTime? selectedShiftStartTime;
  DateTime? selectedShiftEndTime;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    faceDetector = mlkit.GoogleMlKit.vision.faceDetector();
    _getCurrentLocation();
    _loadUserDatas();
    _initializeCameraController();
  }

  _loadUserDatas() async {
    final String? authToken = await StorageUtil.getToken();
    if (authToken != null) {
      final UserModel? userData = await UserService.fetchUserData(authToken);

      if (mounted) {
        if (userData != null) {
          // Dapatkan UserProvider menggunakan konteks
          final userProvider = context.read<UserProvider>();
          userProvider.setUser(userData);

          // Cek apakah shift sudah dipilih sebelumnya
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? savedShift = prefs.getString('selectedShift');
          if (savedShift != null) {
            setState(() {
              selectedShiff = savedShift;
              adjustSelectedShiftTime();
            });
          }
        }
      }
    }
  }

  Future<void> _initializeCameraController() async {
    // Request camera permission
    bool cameraPermission = await Permission.camera.request().isGranted;

    if (!cameraPermission) {
      print('Camera permission denied');
      return;
    }

    final cameras = await availableCameras();
    CameraDescription? selectedCamera;

    for (final camera in cameras) {
      if (camera.lensDirection == CameraLensDirection.front) {
        selectedCamera = camera;
        break;
      }
    }

    if (selectedCamera == null && cameras.isNotEmpty) {
      selectedCamera = cameras.first;
    }

    if (selectedCamera != null) {
      _cameraController = CameraController(
        selectedCamera,
        ResolutionPreset.medium,
      );

      await _cameraController.initialize();
    } else {
      print('Error: Kamera tidak ditemukan');
    }
  }

  Future<void> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.location,
      Permission.microphone,
    ].request();

    if (statuses[Permission.camera] != PermissionStatus.granted ||
        statuses[Permission.location] != PermissionStatus.granted ||
        statuses[Permission.microphone] != PermissionStatus.granted) {
      print("One or more permissions are not granted");
    } else {
      await _initializeCameraController(); // Wait for camera initialization
      _getCurrentLocation();
    }
  }

  @override
  void dispose() {
    if (_cameraController != null && _cameraController.value.isInitialized) {
      _cameraController.dispose();
    }
    faceDetector.close();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      currentPosition = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      setState(() {
        currentPosition;
      });
    } catch (e) {
      print("Error getting current location: $e");
    }
  }

  Future<void> _openScanner(Position position) async {
    try {
      final authToken = await StorageUtil.getToken();

      // Dispose of the existing camera controller if it's not null
      if (_cameraController != null) {
        await _cameraController.dispose();
      }

      final cameras = await availableCameras();
      CameraDescription? selectedCamera;

      // Choose the appropriate camera
      for (final camera in cameras) {
        if (camera.lensDirection == CameraLensDirection.back) {
          selectedCamera = camera;
          break;
        }
      }

      if (selectedCamera != null) {
        _cameraController = CameraController(
          selectedCamera,
          ResolutionPreset.medium,
        );

        await _cameraController.initialize();
      } else {
        print('Error: Back camera not found');
        return;
      }

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
          locQR = result.code!;
          isLoading = true;
          _result =
              '${place.subLocality}, ${place.thoroughfare}, ${place.subAdministrativeArea}, ${place.locality}, Provinsi ${place.administrativeArea}, Kode Pos ${place.postalCode}, ${place.country}';
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _captureAndDetect() async {
    if (_cameraController != null) {
      try {
        if (!_isCameraInitialized || _isBackPressed) {
          await _initializeCameraController();
          _isCameraInitialized = true;
          _isBackPressed = false;
        }
        await _initializeCameraController();
        await _cameraController.setFlashMode(FlashMode.off);
        final cameraScreen = Scaffold(
          key: UniqueKey(),
          body: WillPopScope(
            onWillPop: () async {
              _isBackPressed = true;

              Navigator.pop(context);
              return true;
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: CameraPreview(
                    _cameraController,
                  ),
                ),
                Center(
                  child: Text(
                    'Sedang menangkap foto dan mendeteksi wajah...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

        final cameraScreenRoute =
            MaterialPageRoute(builder: (context) => cameraScreen);
        Navigator.of(context).push(cameraScreenRoute);

        bool faceDetected = false;
        int detectedFaceCount = 0;

        await Future.delayed(Duration(seconds: 1), () async {
          while (!faceDetected && !_isBackPressed) {
            final image = await _cameraController.takePicture();
            final inputImage = mlkit.InputImage.fromFilePath(image.path);

            final List<mlkit.Face> faces =
                await faceDetector.processImage(inputImage);

            detectedFaceCount += faces.length;

            if (faces.isNotEmpty) {
              faceDetected = true;

              print('Detected ${faces.length} face(s)');
              await _saveImageAsPng(image.path);
              print('Foto berhasil disimpan.');

              setState(() {
                resultImagePath = image.path;
                isImageCaptured = true;
                isPhotoTaken = true;
              });
            } else {
              print('No faces detected');
            }
          }
        });

        if (!_isBackPressed) {
          if (isScanned) {
            Navigator.pop(context);
          }

          print('Jumlah wajah terdeteksi: $detectedFaceCount');
          _isCameraInitialized = false;
        }
      } catch (e) {
        print("Error capturing and detecting: $e");
      } finally {
        // Set isLoading to false when the process is complete
        setState(() {
          isLoading = false;
          isImageCaptured = false;
        });
      }
    } else {
      print("Error: Camera controller not initialized");
    }
  }

  void adjustSelectedShiftTime() {
    switch (selectedShiff) {
      case "Shiff 1 jam 08:00 - 17:00":
        selectedShiftStartTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 8, 0, 0);
        selectedShiftEndTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 17, 0, 0);
        break;
      case "Shiff 2 jam 08:30 - 17:30":
        selectedShiftStartTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 8, 3, 0);
        selectedShiftEndTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 17, 3, 0);
        break;
      case "Shiff 3 jam 09:00 - 18:00":
        selectedShiftStartTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 9, 0, 0);
        selectedShiftEndTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 18, 0, 0);
        break;
      case "Shiff 4 jam 19:00 - 10:00":
        selectedShiftStartTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 19, 0, 0);
        selectedShiftEndTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 10, 0, 0);
        break;
      case "Shiff 5 jam 10:00 - 10:08":
        selectedShiftStartTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 10, 0, 0);
        selectedShiftEndTime = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 10, 0, 8);
        break;
      // Add other cases as needed
    }
  }

  Future<void> attendanceInData() async {
    final String? authToken = await StorageUtil.getToken();

    if (authToken != null) {
      try {
        user = await UserService.fetchUserData(authToken);
        if (selectedShiff == null) {
          _showSnackbar('Silahkan Pilih Shiff');
        } else if (resultImagePath == null || resultImagePath.isEmpty) {
          _showSnackbar('Ambil foto terlebih dahulu');
        } else {
          String custId = user?.custID ?? '';
          String officerId = user?.officerID ?? '';
          String officerName = user?.officerName ?? '';
          String pict = resultImagePath;
          AttendanceInService attendanceService = AttendanceInService();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String userId = user?.officerID ?? '';
          String formattedDate =
              "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";

          adjustSelectedShiftTime();
          print(pict);
          DateTime selectedShiftStartTime =
              this.selectedShiftStartTime ?? DateTime.now();

          // Membandingkan waktu sekarang dengan waktu mulai shift
          // if (DateTime.now().isBefore(selectedShiftStartTime)) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content:
          //           Text('Absen tidak diizinkan sebelum waktu shift dimulai'),
          //       duration: Duration(seconds: 2),
          //     ),
          //   );
          //   return;
          // }

          // if (prefs.containsKey('lastAttendanceDate_$userId')) {
          //   if (await StorageUtil.hasUserSubmittedAttendanceToday(userId)) {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //         content: Text('Anda sudah absen hari ini'),
          //         duration: Duration(seconds: 2),
          //       ),
          //     );
          //     return;
          //   }
          // }
          final AttendanceData fetchedAttendanceData =
              await attendanceService.attendanceIn(
            custId,
            officerId,
            officerName,
            locQR,
            currentPosition!.latitude,
            currentPosition!.longitude,
            pict,
            authToken,
          );

          prefs.setString('lastAttendanceDate_$userId', formattedDate);
          prefs.setString('selectedShift', selectedShiff!);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Absen masuk berhasil'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        print('Error fetching data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Absen masuk gagal'),
            duration: Duration(seconds: 2),
          ),
        );
      } finally {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  // Future<void> _saveImageToCloudinary(String imagePath) async {
  //   try {
  //     final fileBytes = await File(imagePath).readAsBytes();
  //     final base64Image = base64Encode(fileBytes);

  //     final cloudinaryUrl =
  //         'https://api.cloudinary.com/v1_1/dq4mjbdd5/image/upload';
  //     final cloudinaryApiKey = '611861861156697';
  //     final cloudinaryApiSecret = '2iBu4JziSwis5po63rN_0TK7mMY';

  //     final response = await http.post(
  //       Uri.parse(cloudinaryUrl),
  //       body: {
  //         'file': 'data:image/png;base64,$base64Image',
  //         'upload_preset':
  //             'vhwe0dxk', // Create an unsigned upload preset in Cloudinary
  //         'api_key': cloudinaryApiKey,
  //         'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
  //         // 'signature': generateCloudinarySignature(cloudinaryApiSecret),
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final cloudinaryResponse = json.decode(response.body);
  //       final cloudinaryImageUrl = cloudinaryResponse['secure_url'];

  //       print('Image uploaded to Cloudinary: $cloudinaryImageUrl');
  //     } else {
  //       print(
  //           'Failed to upload image to Cloudinary. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print("Error saving image to Cloudinary: $e");
  //   }
  // }

  Future<void> _saveImageAsPng(String imagePath) async {
    try {
      final fileBytes = await File(imagePath).readAsBytes();
      const serverUrl = 'http://192.168.18.158/hadirbossque_mada/ui/';

      var request = http.MultipartRequest('POST', Uri.parse(serverUrl));
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          fileBytes,
          filename: '${DateTime.now().millisecondsSinceEpoch}.png',
        ),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Gambar berhasil diunggah.');
      } else {
        print('Gagal mengunggah gambar. Kode status: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print("Error menyimpan gambar sebagai PNG: $e");
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    return Scaffold(
      backgroundColor: AppColor.bekColor,
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
          "Absen Masuk",
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
                height: 350.h,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 243, 241),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Center(
                  child: isScanned
                      ? GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              currentPosition?.latitude ?? 0.0,
                              currentPosition?.longitude ?? 0.0,
                            ),
                            zoom: 18.0,
                          ),
                          onMapCreated: (controller) {
                            mapController = controller;
                          },
                          markers: {
                            google_maps.Marker(
                              markerId: google_maps.MarkerId("0"),
                              position: LatLng(
                                currentPosition?.latitude ?? 0.0,
                                currentPosition?.longitude ?? 0.0,
                              ),
                              icon: google_maps.BitmapDescriptor.defaultMarker,
                            ),
                          },
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
                  color: const Color.fromARGB(255, 255, 243, 241),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 8.w,
                            right: 8.w,
                            top: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.r),
                              topRight: Radius.circular(20.r),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 14.w,
                              right: 14.w,
                              top: 12.h,
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            if (currentPosition != null)
                                              Text(
                                                'Posisi Saat ini : Lat ${currentPosition!.latitude}, Lng ${currentPosition!.longitude}.',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.sp,
                                                ),
                                              )
                                            else
                                              Text(
                                                'Posisi Saat ini :',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.sp,
                                                ),
                                              )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.orange.shade600,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8.r),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 15.w,
                                                vertical: 12.h,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Pindai QR Code Absen",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                  if (isScanned)
                                                    Icon(
                                                      Icons.check_outlined,
                                                      color: Colors.white,
                                                      size: 20.sp,
                                                    )
                                                  else if (isLoading)
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 18.sp,
                                                          height: 18.sp,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        if (isScanned)
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.orange.shade600,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.r),
                                              ),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 15.w,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Pilih Shiff",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 25.w,
                                                ),
                                                DropdownButton(
                                                  value: selectedShiff,
                                                  items: [
                                                    "Shiff 1 jam 08:00 - 17:00",
                                                    "Shiff 2 jam 08:30 - 17:30",
                                                    "Shiff 3 jam 09:00 - 18:00",
                                                    "Shiff 4 jam 19:00 - 10:00",
                                                    "Shiff 5 jam 10:00 - 10:08",
                                                    // Tambahkan lebih banyak item jika diperlukan
                                                  ].map((String value) {
                                                    return DropdownMenuItem(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                  dropdownColor:
                                                      Colors.orange.shade600,
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      selectedShiff = value;
                                                      adjustSelectedShiftTime();
                                                    });
                                                  },
                                                ),
                                                if (isScanned)
                                                  Icon(
                                                    Icons.check_outlined,
                                                    color: Colors.white,
                                                    size: 20.sp,
                                                  ),
                                              ],
                                            ),
                                          )
                                        else
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.orange.shade600,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.r),
                                              ),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 15.w,
                                              vertical: 10.w,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Pilih Shiff",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 25.w,
                                                ),
                                                if (isLoading)
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 18.sp,
                                                        height: 18.sp,
                                                        child:
                                                            CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.optionColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.orange,
                                              width: 2.0.w,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 15.w,
                                            vertical: 10.h,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: 250.w,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Lokasi Tekini',
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text(
                                                      isScanned
                                                          ? _result
                                                          : 'Scan QR terlebih dahulu',
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (isScanned)
                                                Icon(
                                                  Icons.check_outlined,
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  size: 20.sp,
                                                )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await _initializeCameraController();
                                            if (_cameraController != null &&
                                                _cameraController
                                                    .value.isInitialized) {
                                              if (isScanned) {
                                                await _captureAndDetect();
                                              } else {
                                                _showSnackbar(
                                                    "Scan barcode terlebih dahulu");
                                              }
                                            } else {
                                              print(
                                                  "Error: Camera controller not initialized");
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.orange,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 255, 243, 241),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              side: BorderSide(
                                                color: Colors.orange,
                                                width: 2.0.w,
                                              ),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              // horizontal: 5.w,
                                              vertical: 15.h,
                                            ),
                                            child: Container(
                                              // margin: EdgeInsets.only(right: 1),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Take Foto",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                      if (isPhotoTaken)
                                                        Icon(
                                                          Icons.check_outlined,
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 0, 0, 0),
                                                          size: 20.sp,
                                                        )
                                                      else if (isImageCaptured)
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 18.sp,
                                                              height: 18.sp,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                valueColor:
                                                                    AlwaysStoppedAnimation<
                                                                            Color>(
                                                                        Colors
                                                                            .black),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                  Visibility(
                                                    visible: resultImagePath
                                                        .isNotEmpty,
                                                    child: Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              SizedBox(
                                                                child:
                                                                    Image.file(
                                                                  File(
                                                                      resultImagePath),
                                                                  width: 70.w,
                                                                  height: 90.h,
                                                                ),
                                                              ),
                                                              Text(
                                                                userProvider
                                                                    .user!
                                                                    .officerName,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          Container(
                                                            constraints:
                                                                BoxConstraints(
                                                              maxWidth: 120.w,
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  "Klik Foto untuk Mengulang gambar !",
                                                                  style:
                                                                      TextStyle(
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (!isSubmitting) {
                                              if (isScanned) {
                                                setState(() {
                                                  isSubmitting = true;
                                                });
                                                await attendanceInData();
                                              } else {
                                                _showSnackbar(
                                                    "Scan barcode terlebih dahulu");
                                              }
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor:
                                                Colors.orange.shade600,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              // horizontal: 21.w,
                                              vertical: 15.h,
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Kirim Absen Masuk",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
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
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.center_focus_strong),
        onPressed: () async {
          await _initializeCameraController();

          if (_cameraController != null &&
              _cameraController.value.isInitialized) {
            // await _captureAndDetect();
          } else {
            print("Error: Camera controller not initialized");
          }
          // Rest of your code for FloatingActionButton onPressed...
          final snackBar = SnackBar(
            content: Row(
              children: [
                Text('Harap Tunggu...'),
              ],
            ),
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          Position position;
          try {
            position = await GeolocationUtils.getGeoLocationPosition();
          } catch (e) {
            print("Error getting location: $e");
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Gagal akses pemindaian.'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
