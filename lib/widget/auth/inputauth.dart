// ignore_for_file: unused_import, file_names, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporbos/color.dart';

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
