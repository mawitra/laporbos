// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporbos/handler/authHandler.dart';
import 'package:laporbos/screens/auth/register.dart';
import 'package:laporbos/color.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                    'Selamat Datang !!!',
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
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Login",
                                      style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25.sp,
                                      ),
                                    ),
                                    Text(
                                      "Silakan masuk dengan akun Anda",
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
                                      controller: usernameController,
                                      placeholder: "Username / Nomor Whatsapp",
                                      validasi:
                                          '* Username / Nomor Whatsapp tidak boleh kosong',
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    InputPassword(
                                      controller: passwordController,
                                      sandi: "Masukan Kata Sandi",
                                      validasi:
                                          "* Kata sandi harus dari 8 - 16 karakter",
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Text(
                                            "Lupa Password",
                                            style: TextStyle(
                                              color: AppColor.textColor,
                                            ),
                                          ),
                                        )
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
                                          AuthHandler().handleLogin(
                                              context,
                                              usernameController.text,
                                              passwordController.text);
                                        },
                                        child: Text(
                                          "Login",
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
                                          "Belum Punya Akun?",
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
                                                  return Register(); // Ganti dengan halaman Register yang sesuai
                                                },
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "Daftar Sekarang",
                                            style: TextStyle(
                                              color: AppColor.primaryColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
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

class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    required this.placeholder,
    required this.validasi,
    required this.controller,
  });

  final String placeholder;
  final String validasi;
  final TextEditingController controller; // Gunakan controller yang diberikan

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
                controller: widget.controller,
                style: TextStyle(color: AppColor.primaryColor),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.account_circle,
                    color: AppColor.primaryColor,
                    size: 20.sp,
                  ),
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
