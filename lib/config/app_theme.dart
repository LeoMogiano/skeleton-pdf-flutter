import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Work Sans',
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 18.sp,
          fontFamily: 'Work Sans',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      // CircularProgressIndicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFF47A8EB),
        // circularTrackColor: Colors.grey.withValues(alpha: 0.2),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(90.w, 5.h),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: const Color(0xFF47A8EB),
          foregroundColor: Colors.white,
          overlayColor: Colors.black.withValues(alpha: 0.2),
        ),
      ),
    );
  }
}
