import 'package:flutter/material.dart';
import 'package:laporbos/color.dart';

class People extends StatelessWidget {
  const People({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
    );
  }
}
