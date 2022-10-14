import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyle {
  TextStyle myTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
  );

  TextStyle myTiteStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20.sp,
    
  );

  TextStyle mySmallStyle = TextStyle(
    fontSize: 18.sp,
    
  );

  InputDecoration textFieldDecoration(hint) => InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      fontSize: 17.sp,
    ),
    border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xFFC5C5C5))),

  );
}