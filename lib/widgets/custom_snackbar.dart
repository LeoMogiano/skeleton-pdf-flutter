import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    IconData icon = Icons.check_circle,
    Color backgroundColor = Colors.black87,
    Duration duration = const Duration(seconds: 2),
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: Navigator.of(context),
    );

    final animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    controller.forward();

    scaffoldMessenger.showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: backgroundColor,
        duration: duration,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 2.h,
        ),
        content: FadeTransition(
          opacity: animation,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              Icon(icon, color: Colors.white, size: 6.w),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Future.delayed(duration - const Duration(milliseconds: 500), () {
      if (controller.status == AnimationStatus.forward) {
        controller.reverse();
      }
    });
  }
}
