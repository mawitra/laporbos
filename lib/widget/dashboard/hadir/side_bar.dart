// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable, unused_import

import 'package:flutter/material.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/screens/auth/login.dart';
import 'package:laporbos/screens/dashboard/hadir/absen_masuk.dart';
import 'package:laporbos/screens/dashboard/hadir/absen_pulang.dart';
import 'package:laporbos/screens/dashboard/hadir/daftar_absen.dart';
import 'package:laporbos/screens/dashboard/hadir/hadirbos.dart';
import 'package:laporbos/screens/dashboard/superAdmin/petugas/daftar_petugas.dart';
import 'package:laporbos/widget/dashboard/bottomnavigation.dart';
import 'package:laporbos/widget/dashboard/hadir/drawer_item.dart';
// import 'package:laporbos/widget/dashboard/hadir/people.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int index_color = 0;

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
              const SizedBox(height: 40),
              const Divider(
                thickness: 1,
                height: 10,
                color: Colors.black,
              ),
              const SizedBox(height: 40),
              DrawerItem(
                name: 'Home',
                icon: Icons.home,
                onTap: () {
                  setState(() {
                    index_color = 0;
                  });

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => HomeHadirBos(),
                  ));
                },
              ),
              const SizedBox(height: 30),
              DrawerItem(
                name: 'Daftar Absensi',
                icon: Icons.assignment_outlined,
                onTap: () {
                  setState(() {
                    index_color = 1;
                  });

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => DaftarAbsen(),
                  ));
                },
              ),
              const SizedBox(height: 30),
              DrawerItem(
                name: 'Absen Masuk',
                icon: Icons.message_outlined,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => AbsenMasuk(),
                  ));
                },
              ),
              const SizedBox(height: 30),
              DrawerItem(
                name: 'Absen Keluar',
                icon: Icons.favorite_outline,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => AbsenPulang(),
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
      ClipOval(
        child: Image.asset(
          'assets/images/a.jpeg',
          width: 90,
          height: 90,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(
        width: 20,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Mada Dwi Saputra',
              style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 5,
          ),
          Text('person@email.com',
              style: TextStyle(fontSize: 15, color: Colors.black))
        ],
      )
    ],
  );
}
