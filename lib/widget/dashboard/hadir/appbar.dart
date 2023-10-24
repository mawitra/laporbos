import 'package:flutter/material.dart';
import 'package:laporbos/color.dart';

class CustomAppBarr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      backgroundColor: AppColor.primaryColor,
      elevation: 0,

      title: Text(
        "Nama Aplikasi", // Ganti dengan judul aplikasi Anda
        style: TextStyle(
          color: Colors.black, // Ganti warna teks sesuai kebutuhan Anda
        ),
      ),
      centerTitle: true, // Mengarahkan teks ke tengah AppBar
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.logout, color: Colors.black), // Ikon Logout
          onPressed: () {
            // Tambahkan logika logout di sini
          },
        ),
      ],
    );
  }
}
