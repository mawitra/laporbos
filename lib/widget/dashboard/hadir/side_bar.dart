// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable, unused_import

import 'package:flutter/material.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/model/user.dart';
import 'package:laporbos/screens/auth/login.dart';
import 'package:laporbos/screens/dashboard/hadir/absen_masuk.dart';
import 'package:laporbos/screens/dashboard/hadir/absen_pulang.dart';
import 'package:laporbos/screens/dashboard/hadir/daftar_absen.dart';
import 'package:laporbos/screens/dashboard/hadir/hadirbos.dart';
import 'package:laporbos/screens/dashboard/superAdmin/petugas/daftar_petugas.dart';
import 'package:laporbos/service/userService.dart';
import 'package:laporbos/utils/storage.dart';
import 'package:laporbos/widget/dashboard/bottomnavigation.dart';
import 'package:laporbos/widget/dashboard/hadir/drawer_item.dart';
// import 'package:laporbos/widget/dashboard/hadir/people.dart';

class CustomDrawer extends StatefulWidget {
  final Function(int) onIndexSelected;

  const CustomDrawer({Key? key, required this.onIndexSelected})
      : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int index_color = 0;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    final String? authToken = await StorageUtil.getToken();
    if (authToken != null) {
      final UserModel? userData = await UserService.fetchUserData(authToken);

      if (userData != null) {
        setState(() {
          user = userData;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.deepOrange.shade50,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
          child: Column(
            children: [
              headerWidget(),
              const SizedBox(height: 30),
              const Divider(
                thickness: 1,
                height: 10,
                color: Colors.black,
              ),
              const SizedBox(height: 30),
              DrawerItem(
                name: 'Home',
                icon: Icons.home,
                onTap: () {
                  widget.onIndexSelected(0);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Bottom(
                      initialIndex: 0,
                      onIndexChanged: (int newIndex) {
                        // Tambahkan logika yang sesuai di sini
                      },
                    ),
                  ));
                },
              ),
              const SizedBox(height: 30),
              DrawerItem(
                name: 'Daftar Absensi',
                icon: Icons.assignment_outlined,
                onTap: () {
                  widget.onIndexSelected(1);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Bottom(
                      initialIndex: 1,
                      onIndexChanged: (int newIndex) {
                        // Tambahkan logika yang sesuai di sini
                      },
                    ),
                  ));
                },
              ),
              const SizedBox(height: 30),
              DrawerItem(
                name: 'Absen Masuk',
                icon: Icons.message_outlined,
                onTap: () {
                  widget.onIndexSelected(2);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Bottom(
                      initialIndex: 2,
                      onIndexChanged: (int newIndex) {
                        // Tambahkan logika yang sesuai di sini
                      },
                    ),
                  ));
                },
              ),
              const SizedBox(height: 30),
              DrawerItem(
                name: 'Absen Keluar',
                icon: Icons.favorite_outline,
                onTap: () {
                  widget.onIndexSelected(3);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Bottom(
                      initialIndex: 3,
                      onIndexChanged: (int newIndex) {
                        // Tambahkan logika yang sesuai di sini
                      },
                    ),
                  ));
                },
              ),
              const SizedBox(height: 30),
              const Divider(
                thickness: 1,
                height: 10,
                color: Colors.black,
              ),
              const SizedBox(height: 30),
              DrawerItem(
                name: 'Setting',
                icon: Icons.settings,
                onTap: () {},
              ),
              const SizedBox(height: 30),
              DrawerItem(
                name: 'Log out',
                icon: Icons.logout,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget headerWidget() {
  return Row(
    // ignore: prefer_const_literals_to_create_immutables
    children: [
      // ClipOval(
      //   child: Image.asset(
      //     'assets/images/a.jpeg',
      //     width: 90,
      //     height: 90,
      //     fit: BoxFit.cover,
      //   ),
      // ),
      // const SizedBox(
      //   width: 20,
      // ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (user != null)
            Text(user!.officerName,
                style: TextStyle(fontSize: 15, color: Colors.black)),

          SizedBox(height: 10), // Tambahkan ruang di antara teks
          Text('person@email.com',
              style: TextStyle(fontSize: 15, color: Colors.black))
        ],
      )
    ],
  );
}
