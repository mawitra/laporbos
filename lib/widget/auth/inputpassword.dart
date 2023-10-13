// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporbos/color.dart';

class InputPassword extends StatefulWidget {
  const InputPassword({
    Key? key,
    required this.controller,
    required this.sandi,
    required this.validasi,
  }) : super(key: key);

  final TextEditingController controller; // Gunakan controller yang diberikan
  final String sandi;
  final String validasi;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  var obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              cursorColor:
                  AppColor.primaryColor, // Ganti dengan warna yang sesuai
              style: TextStyle(
                  color:
                      AppColor.primaryColor), // Ganti dengan warna yang sesuai
              obscureText: obscureText,
              controller:
                  widget.controller, // Gunakan controller yang diberikan
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock, // Ikon di kiri
                  color: AppColor.primaryColor, // Warna ikon
                  size: 20, // Ukuran ikon
                ),
                hintText: widget.sandi,
                hintStyle: TextStyle(
                    color: Colors.grey), // Ganti dengan warna yang sesuai
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: obscureText
                      ? Icon(Icons.visibility_off, color: AppColor.primaryColor)
                      : Icon(Icons.visibility,
                          color: Colors
                              .red), // Sesuaikan warna ikon sesuai kebutuhan
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey, // Ganti dengan warna yang sesuai
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        AppColor.primaryColor, // Warna border saat dalam fokus
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return widget.validasi;
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
