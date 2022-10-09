import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyle {
  TextStyle myTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
  );

  InputDecoration textFieldDecoration(hint) => InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      fontSize: 15.sp,
    ),

  );
}