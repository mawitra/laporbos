// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/screens/auth/login.dart';
import 'package:laporbos/screens/dashboard/hadir/hadirbos.dart';
import 'package:laporbos/screens/dashboard/superAdmin/petugas/daftar_petugas.dart';
import 'package:laporbos/widget/dashboard/bottomnavigation.dart';
import 'package:laporbos/widget/dashboard/hadir/drawer_item.dart';
import 'package:laporbos/widget/dashboard/hadir/people.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index_color = 0;
    List Screen = [
      HomeHadirBos(),
      DaftarPetugas(),
    ];
    return Drawer(
      child: Material(
        color: Colors.deepOrange.shade50,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
          child: Column(
            children: [
              headerWidget(),
              const SizedBox(
                height: 40,
              ),
              const Divider(
                thickness: 1,
                height: 10,
                color: Colors.black,
              ),
              const SizedBox(
                height: 40,
              ),
              DrawerItem(
                name: 'Beranda',
                icon: Icons.home,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Bottom(),
                  ));
                },
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerItem(
                name: 'Daftar Absensi',
                icon: Icons.account_box_rounded,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => DaftarPetugas(),
                  ));
                },
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerItem(
                name: 'Absen Masuk',
                icon: Icons.message_outlined,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Bottom(),
                  ));
                },
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerItem(
                name: 'Absen Keluar',
                icon: Icons.favorite_outline,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Bottom(),
                  ));
                },
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                thickness: 1,
                height: 10,
                color: Colors.black,
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerItem(
                name: 'Setting',
                icon: Icons.settings,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Bottom(),
                  ));
                },
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerItem(
                name: 'Log out',
                icon: Icons.logout,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Bottom(),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerWidget() {
    return Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Image.asset(
          'assets/images/orang-tua.png', // Ganti dengan path gambar yang sesuai
          width: 90, // Sesuaikan lebar gambar
          height: 100, // Sesuaikan tinggi gambar
          fit: BoxFit.cover, // Sesuaikan dengan kebutuhan
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Person name',
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
}
