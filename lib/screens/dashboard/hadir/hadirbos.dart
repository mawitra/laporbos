// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laporbos/color.dart';
import 'package:laporbos/screens/auth/login.dart';
import 'package:laporbos/screens/dashboard/lapor/laporbos.dart';
import 'package:laporbos/widget/dashboard/hadir/header.dart';
import 'package:laporbos/widget/dashboard/hadir/scroll_bar.dart';
import 'package:laporbos/widget/dashboard/hadir/side_bar.dart';

class HomeHadirBos extends StatefulWidget {
  const HomeHadirBos({Key? key}) : super(key: key);

  @override
  State<HomeHadirBos> createState() => _HomeHadirBosState();
}

class _HomeHadirBosState extends State<HomeHadirBos> {
  var history;
  // final box = Hive.box<Add_data>('data');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: Colors.deepOrange.shade50,
      appBar: AppBar(
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
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 220, child: Header()),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 160, child: SpecialOffers()),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Absen Terakhir',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'View all',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 5), // Add some space above the card list
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Card(
                    color: Colors.deepOrange.shade50,
                    elevation: 5,
                    margin: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5), // Adjust vertical margin as needed
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Image.asset(
                              'assets/images/hadirbos.png'), // Replace with your image path
                          title: const Text('Demo Title'),
                          subtitle:
                              const Text('This is a simple card in Flutter.'),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 5, // This will create 5 cards
              ),
            ),
          ],
        ),
      ),
    );
  }
}
