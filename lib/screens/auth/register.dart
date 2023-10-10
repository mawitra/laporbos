// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporbos/screens/auth/login.dart';
import 'package:laporbos/color.dart';
import 'package:file_picker/file_picker.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? filePath;
  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png'
      ], // Contoh ekstensi yang diizinkan
    );

    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColor.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 25.h),
                    child: Image(
                      width: 150.w,
                      height: 150.h,
                      image: AssetImage('assets/images/hadirbos.png'),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'Belum Punya Akun ???',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Expanded(
                    child: Container(
                      width: 360.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.r),
                          topRight: Radius.circular(40.r),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 30.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Register",
                                      style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25.sp,
                                      ),
                                    ),
                                    Text(
                                      "Silakan buat akun anda di sini",
                                      style: TextStyle(
                                        color: AppColor.textColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40.h,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextInput(
                                      placeholder:
                                          "Id Pelanggan / contoh 'XYZ'",
                                      validasi:
                                          "* Id Pelanggan tidak boleh kosong",
                                      icon: Icon(
                                        Icons.key, // Ikon di kiri
                                        color:
                                            AppColor.primaryColor, // Warna ikon
                                        size: 20.sp, // Ukuran ikon
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    TextInput(
                                      placeholder:
                                          "Nama Pelanggan / contoh 'PT. XYZ'",
                                      validasi:
                                          "* Nama pelanggan 2 - 25 karakter",
                                      icon: Icon(
                                        Icons
                                            .add_home_work_outlined, // Ikon di kiri
                                        color:
                                            AppColor.primaryColor, // Warna ikon
                                        size: 20.sp, // Ukuran ikon
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    TextInput(
                                      placeholder:
                                          "Nama Pengguna / contoh 'Admin'",
                                      validasi:
                                          "* Nama Pengguna tidak boleh kosong",
                                      icon: Icon(
                                        Icons.account_circle, // Ikon di kiri
                                        color:
                                            AppColor.primaryColor, // Warna ikon
                                        size: 20.sp, // Ukuran ikon
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    TextInput(
                                      placeholder:
                                          "Alamat / contoh 'Bandung, Jawa Barat'",
                                      validasi: "* Alamat tidak boleh kosong",
                                      icon: Icon(
                                        Icons.place_outlined, // Ikon di kiri
                                        color:
                                            AppColor.primaryColor, // Warna ikon
                                        size: 20.sp, // Ukuran ikon
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    TextInput(
                                      placeholder:
                                          "Email / contoh 'xyz@gmail.com'",
                                      validasi:
                                          "* Alamat email tidak boleh kosong",
                                      icon: Icon(
                                        Icons.mail_outline, // Ikon di kiri
                                        color:
                                            AppColor.primaryColor, // Warna ikon
                                        size: 20.sp, // Ukuran ikon
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    InputPassword(
                                      controller: TextEditingController(),
                                      sandi: "Masukan Kata Sandi",
                                      validasi:
                                          "* Kata sandi harus terdiri dari 8 - 16 karakter",
                                      icon: Icon(
                                        Icons.lock, // Ikon di kiri
                                        color:
                                            AppColor.primaryColor, // Warna ikon
                                        size: 20.sp, // Ukuran ikon
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    InputPassword(
                                      controller: TextEditingController(),
                                      sandi: "Ulangi Kata Sandi",
                                      validasi: "* kata sandi harus sama",
                                      icon: Icon(
                                        Icons.lock, // Ikon di kiri
                                        color:
                                            AppColor.primaryColor, // Warna ikon
                                        size: 20.sp, // Ukuran ikon
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    TextInput(
                                      placeholder:
                                          "Telp / contoh '082122324809'",
                                      validasi: "* Nomor telepon tidak valid!",
                                      icon: Icon(
                                        Icons.phone, // Ikon di kiri
                                        color:
                                            AppColor.primaryColor, // Warna ikon
                                        size: 20.sp, // Ukuran ikon
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    TextInput(
                                      placeholder:
                                          "NPWP / contoh '0.2.324.352.3-652.342'",
                                      validasi:
                                          "* kolom ini tidak boleh kosong",
                                      icon: Icon(
                                        Icons
                                            .assignment_rounded, // Ikon di kiri
                                        color:
                                            AppColor.primaryColor, // Warna ikon
                                        size: 20.sp, // Ukuran ikon
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Uplod File NPWP",
                                          style: TextStyle(
                                              color: AppColor.textColor),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: _openFilePicker,
                                          child: Text('Choose File'),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColor.primaryColor),
                                        ),
                                        SizedBox(width: 16),
                                        Text(
                                          filePath ?? 'No file selected',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColor.textColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColor.primaryColor
                                                .withOpacity(
                                                    0.2), // Warna shadow
                                            spreadRadius:
                                                2, // Jarak penyebaran shadow
                                            blurRadius: 5, // Blur radius shadow
                                            offset: Offset(
                                                0, 5), // Offset shadow (x, y)
                                          ),
                                        ],
                                      ),
                                      width: double.infinity,
                                      child: TextButton(
                                        onPressed: () {
                                          // Aksi yang ingin Anda lakukan saat tombol ditekan
                                        },
                                        child: Text(
                                          "Daftar",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        "Or Login With",
                                        style: TextStyle(
                                          color: AppColor.textColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Sudah Memiliki Akun?",
                                          style: TextStyle(
                                            color: AppColor.textColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return Login(); // Ganti dengan halaman Register yang sesuai
                                                },
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "Masuk",
                                            style: TextStyle(
                                              color: AppColor.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputPassword extends StatefulWidget {
  const InputPassword({
    Key? key,
    required this.controller,
    required this.sandi,
    required this.validasi,
    required this.icon,
  }) : super(key: key);

  final TextEditingController controller;
  final String sandi;
  final String validasi;
  final Icon icon;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  var obscureText = true;
  String? inputValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              cursorColor: AppColor.primaryColor,
              style: TextStyle(color: AppColor.primaryColor),
              obscureText: obscureText,
              controller: widget.controller,
              decoration: InputDecoration(
                prefixIcon: widget.icon,
                hintText: widget.sandi,
                hintStyle: TextStyle(color: AppColor.hintColor),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: obscureText
                      ? Icon(Icons.visibility_off, color: AppColor.primaryColor)
                      : Icon(Icons.visibility, color: AppColor.sekunderColor),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor
                        .strokeColor, // Ganti dengan warna yang Anda inginkan
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        AppColor.primaryColor, // Warna border saat dalam fokus
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  inputValue = value;
                });
              },
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

class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    required this.placeholder,
    required this.validasi,
    required this.icon,
  });

  final String placeholder;
  final String validasi;
  final Icon icon;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  String? inputValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: TextFormField(
                cursorColor: AppColor.primaryColor,
                autocorrect: false,
                style: TextStyle(color: AppColor.primaryColor),
                decoration: InputDecoration(
                  prefixIcon: widget.icon,
                  hintText: widget.placeholder,
                  hintStyle: TextStyle(
                    color: AppColor.hintColor,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.strokeColor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    inputValue = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return widget.validasi;
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
