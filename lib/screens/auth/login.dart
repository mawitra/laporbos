// ignore_for_file: prefer_const_constructors, unused_local_variable, use_build_context_synchronously, avoid_print, library_prefixes, unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporbos/handler/authHandler.dart';
import 'package:laporbos/service/AuthService.dart';
import 'package:laporbos/screens/auth/register.dart';
import 'package:laporbos/widget/auth/inputauth.dart' as AuthWidgets;
import 'package:laporbos/widget/auth/inputpassword.dart' as AuthWidgets;
import 'package:laporbos/color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void handleLogin() {
    AuthHandler(context).handleLogin(
      usernameController.text,
      passwordController.text,
    );
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
                                    AuthWidgets.TextInput(
                                      controller: usernameController,
                                      placeholder: "Username / Nomor Whatsapp",
                                      validasi:
                                          '* Username / Nomor Whatsapp tidak boleh kosong',
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    AuthWidgets.InputPassword(
                                      controller: passwordController,
                                      sandi: "Masukan Kata Sandi",
                                      validasi:
                                          "* Kata sandi harus dari 8 - 16 karakter",
                                    ),
                                    // SizedBox(
                                    //   height: 20.h,
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.start,
                                    //   children: [
                                    //     InkWell(
                                    //       onTap: () {},
                                    //       child: Text(
                                    //         "Lupa Password",
                                    //         style: TextStyle(
                                    //           color: AppColor.textColor,
                                    //         ),
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
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
                                        onPressed: handleLogin,
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

// class AuthHandler {
//   final BuildContext context;

//   String? authToken; // Store the access token
//   DateTime? tokenExpirationTime; // Store the expiration time
//   Timer? tokenRefreshTimer; // Timer for redirecting after token expiration

//   AuthHandler(this.context);

//   Future<void> handleLogin(String username, String password) async {
//     final url = Uri.parse('http://192.168.18.158:8000/api/login/officer');

//     try {
//       final response = await http.post(
//         url,
//         body: {
//           'username': username,
//           'password': password,
//         },
//       ).timeout(const Duration(seconds: 15));

//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         authToken = responseData['access_token'];
//         final expiresIn = responseData['expires_in'];
//         tokenExpirationTime = DateTime.now().add(
//           Duration(seconds: expiresIn),
//         );
//         tokenRefreshTimer = Timer(
//           Duration(minutes: 5), // Set to 5 minutes
//           () {
//             Navigator.of(context).pushReplacement(MaterialPageRoute(
//               builder: (context) =>
//                   Login(), // Replace with the appropriate login page
//             ));
//           },
//         );

//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => Home(),
//         ));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Login failed. Please check your credentials.'),
//           ),
//         );
//       }
//     } catch (e) {
//       print('Error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('An error occurred. Please try again later.'),
//         ),
//       );
//     }
//   }
// }
