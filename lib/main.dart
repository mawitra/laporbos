// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laporbos/screens/auth/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporbos/screens/auth/register.dart';
import 'package:laporbos/screens/dashboard/hadir/hadirbos.dart';
import 'package:laporbos/screens/dashboard/superAdmin/home.dart';
import 'package:laporbos/provider/userProvider.dart';
import 'package:laporbos/widget/dashboard/bottomnavigation.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
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
          home: Bottom(
            initialIndex: 0,
            onIndexChanged: (int newIndex) {
              // Tambahkan logika yang sesuai di sini
            },
          ),
        );
      },
    );
  }
}
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Geo Tagging',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: const MyHomePage(title: 'Demo Aplikasi Geo Tagging'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State {
//   String strLatLong = 'Belum Mendapatkan Lat dan Long, Silahkan tekan tombol';
//   String strAlamat = 'Mencari lokasi...';
//   bool loading = false;

//   //getLatLong
//   Future _getGeoLocationPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     //location service not enabled, don't continue
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return Future.error('Location service Not Enabled');
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permission denied');
//       }
//     }

//     //permission denied forever
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//         'Location permission denied forever, we cannot access',
//       );
//     }
//     //continue accessing the position of device
//     return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//   }

//   // //getAddress
//   Future getAddressFromLongLat(Position position) async {
//     List placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     print(placemarks);

//     Placemark place = placemarks[0];
//     setState(() {
//       strAlamat = '${place.street}, ${place.subLocality}, ${place.locality}, '
//           '${place.postalCode}, ${place.country}';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Titik Koordinat',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(
//               height: 40,
//             ),
//             const Text(
//               'Alamat',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             loading
//                 ? const Center(child: CircularProgressIndicator())
//                 : ElevatedButton(
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(Colors.green),
//                       shape: MaterialStateProperty.all(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                           side: const BorderSide(color: Colors.green),
//                         ),
//                       ),
//                     ),
//                     onPressed: () async {
//                       setState(() {
//                         loading = true;
//                       });

//                       Position position = await _getGeoLocationPosition();
//                       setState(() {
//                         loading = false;
//                         strLatLong =
//                             '${position.latitude}, ${position.longitude}';
//                       });

//                       getAddressFromLongLat(position);
//                     },
//                     child: const Text('Tagging Lokasi'),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
