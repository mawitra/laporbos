// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Untuk mengatur teks ke tengah
        child: Text(
          'Welcome Dashboard',
          style: TextStyle(
            fontSize: 32, // Ukuran teks
            fontWeight: FontWeight.bold, // Ketebalan teks
          ),
        ),
      ),
    );
  }
}
